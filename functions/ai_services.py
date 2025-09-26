from flask import Blueprint, request, jsonify
import requests
import os
import json
import base64
from io import BytesIO
from PIL import Image
import numpy as np
from extensions.extensions import get_db_connection
import google.generativeai as genai

ai_services_bp = Blueprint("ai_services", __name__)

# Configure Gemini API key (hardcoded as requested)
GEMINI_API_KEY = "AIzaSyBrEffEkJw_KFY2XDHWRt0B3jmobfLmAQE"
genai.configure(api_key=GEMINI_API_KEY)

@ai_services_bp.route("/estimate-dimensions", methods=["POST"])
def estimate_dimensions():
    try:
        data = request.get_json()
        if not data or 'imageUrl' not in data:
            return jsonify({"error": "No image URL provided"}), 400
        
        image_url = data['imageUrl']
        title = data.get('title', '')
        description = data.get('description', '')
        
        # Download the image from the URL
        try:
            response = requests.get(image_url)
            if response.status_code != 200:
                return jsonify({"error": "Failed to download image"}), 400
            
            image_data = response.content
        except Exception as e:
            print(f"Error downloading image: {str(e)}")
            return jsonify({"error": "Failed to download image"}), 400
        
        # Process the image to estimate dimensions and weight using AI
        dimensions, weight = estimate_from_image_ai(image_data, title, description)
        
        # Log the estimation in database
        try:
            log_ai_estimation(image_url, title, description, dimensions, weight)
        except Exception as e:
            print(f"Warning: Could not log estimation: {str(e)}")
        
        return jsonify({
            "dimensions": dimensions,
            "weight": weight
        })
    
    except Exception as e:
        print(f"Error in dimension estimation: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

def estimate_from_image_ai(image_data, title="", description=""):
    """
    Estimate dimensions and weight from image data using Google's Gemini API
    """
    try:
        # Convert image to bytes for Gemini API
        img = Image.open(BytesIO(image_data))
        
        # Create a new BytesIO object for the image
        buffered = BytesIO()
        img.save(buffered, format="JPEG")
        img_bytes = buffered.getvalue()
        
        # Create prompt with context
        prompt = f"""
        Analyze this product image and estimate its physical dimensions (length, width, height in inches) 
        and weight (in pounds). 
        
        Product title: {title}
        Product description: {description}
        
        Provide your best estimate based on visual cues, relative size, and any context from the title/description.
        Return ONLY a JSON object with the following format:
        {{
            "dimensions": {{
                "length": float,
                "width": float,
                "height": float
            }},
            "weight": float
        }}
        """
        
        # Set up the Gemini model - Updated to use current model name
        model = genai.GenerativeModel('gemini-2.5-flash')
        
        # Call Gemini API with image
        response = model.generate_content([
            prompt,
            {"mime_type": "image/jpeg", "data": img_bytes}
        ])
        
        # Extract the response text
        result_text = response.text
        
        # Parse the JSON from the response
        # Find JSON object in the response text
        import re
        json_match = re.search(r'({[\s\S]*})', result_text)
        if json_match:
            json_str = json_match.group(1)
            try:
                result = json.loads(json_str)
                dimensions = result.get("dimensions", {"length": 10, "width": 8, "height": 4})
                weight = result.get("weight", 2.0)
                return dimensions, weight
            except json.JSONDecodeError:
                print("Failed to parse JSON from Gemini response")
        
        # Fallback to default values if parsing fails
        return {"length": 10, "width": 8, "height": 4}, 2.0
        
    except Exception as e:
        print(f"Error using AI for image estimation: {str(e)}")
        # Fallback to the original estimation method if AI fails
        return estimate_from_image_fallback(image_data, title, description)

def estimate_from_image_fallback(image_data, title="", description=""):
    """
    Fallback estimation method when AI service is unavailable
    """
    try:
        # Open the image using PIL
        img = Image.open(BytesIO(image_data))
        
        # Get image dimensions
        width, height = img.size
        
        # Convert to numpy array for processing
        img_array = np.array(img)
        
        # Simple heuristic based on image size and pixel values
        pixel_density = np.mean(img_array)
        aspect_ratio = width / height
        
        # Simplified dimension estimation
        if "small" in title.lower() or "mini" in title.lower():
            size_factor = 0.5
        elif "large" in title.lower() or "big" in title.lower():
            size_factor = 2.0
        else:
            size_factor = 1.0
        
        # Base dimensions in inches
        base_length = 10 * size_factor
        base_width = 8 * size_factor
        base_height = 4 * size_factor
        
        # Adjust based on aspect ratio
        if aspect_ratio > 1.5:
            # Wide object
            length = base_length * 1.2
            width = base_width * 0.9
        elif aspect_ratio < 0.7:
            # Tall object
            length = base_length * 0.9
            width = base_width * 0.8
            base_height = base_height * 1.3
        else:
            # Regular proportions
            length = base_length
            width = base_width
        
        # Estimate weight based on dimensions and image characteristics
        volume = length * width * base_height
        density_factor = pixel_density / 128  # Normalize pixel density
        
        # Base weight in pounds
        weight = (volume / 100) * density_factor
        
        # Adjust weight based on keywords in title and description
        if any(word in title.lower() + " " + description.lower() for word in ["heavy", "metal", "steel", "iron"]):
            weight *= 1.5
        elif any(word in title.lower() + " " + description.lower() for word in ["light", "plastic", "foam", "paper"]):
            weight *= 0.6
        
        # Round to reasonable values
        dimensions = {
            "length": round(length, 1),
            "width": round(width, 1),
            "height": round(base_height, 1)
        }
        
        return dimensions, round(weight, 2)
        
    except Exception as e:
        print(f"Error processing image: {str(e)}")
        # Return default values if estimation fails
        return {"length": 10, "width": 8, "height": 4}, 2.0

def log_ai_estimation(image_url, title, description, dimensions, weight):
    """Log AI estimation to database for tracking and analytics"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # First check if the table exists, create it if it doesn't
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS ai_estimations (
                id INT AUTO_INCREMENT PRIMARY KEY,
                image_url TEXT,
                title VARCHAR(255),
                description TEXT,
                dimensions JSON,
                weight FLOAT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        """)
        conn.commit()
        
        # Now insert the data
        cursor.execute("""
            INSERT INTO ai_estimations (image_url, title, description, dimensions, weight, created_at)
            VALUES (%s, %s, %s, %s, %s, NOW())
        """, (
            image_url, 
            title, 
            description, 
            json.dumps(dimensions), 
            weight
        ))
        
        conn.commit()
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Error logging AI estimation: {str(e)}")
        raise

@ai_services_bp.route("/generate-description", methods=["POST"])
def generate_description():
    """Generate product description based on image and basic info using Gemini"""
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "No data provided"}), 400
        
        image_url = data.get('imageUrl')
        title = data.get('title', '')
        category = data.get('category', '')
        
        try:
            # Download the image if URL is provided
            img_bytes = None
            if image_url:
                response = requests.get(image_url)
                if response.status_code == 200:
                    img_bytes = response.content
            
            # Set up the Gemini model - Updated to use current model name
            model = genai.GenerativeModel('gemini-2.5-flash' if img_bytes else 'gemini-2.5-flash')
            
            # Create prompt
            prompt = f"Write a compelling product description for this {category} product titled '{title}'. Keep it under 100 words, highlight key features, and make it engaging for potential buyers."
            
            # Call Gemini API
            if img_bytes:
                response = model.generate_content([
                    prompt,
                    {"mime_type": "image/jpeg", "data": img_bytes}
                ])
            else:
                response = model.generate_content(prompt)
            
            description = response.text
            return jsonify({"description": description})
                
        except Exception as e:
            print(f"Error using Gemini for description: {str(e)}")
            # Fall back to template-based description
        
        # Fallback: Template-based description generation
        descriptions = [
            f"This premium {category} product offers exceptional quality and value. {title} is designed with attention to detail and craftsmanship.",
            f"Introducing {title}, a standout {category} that combines style and functionality. Perfect for everyday use.",
            f"Elevate your {category} collection with {title}. This product features modern design elements and practical features.",
            f"The {title} is a versatile {category} item that meets all your needs. Crafted with premium materials for lasting durability.",
            f"{title} represents the perfect blend of form and function in the {category} category. A must-have addition to your collection."
        ]
        
        import random
        description = random.choice(descriptions)
        
        return jsonify({"description": description})
    
    except Exception as e:
        print(f"Error generating description: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@ai_services_bp.route("/analyze-text", methods=["POST"])
def analyze_text():
    """Analyze product text to suggest improvements using OpenAI"""
    try:
        data = request.get_json()
        if not data or 'text' not in data:
            return jsonify({"error": "No text provided"}), 400
        
        text = data['text']
        
        try:
            # Use OpenAI for text analysis
            prompt = f"""Analyze this product description and provide:
            1. Word count
            2. Sentiment analysis (positive, neutral, negative)
            3. 2-3 specific suggestions for improvement
            
            Return ONLY a JSON object with format: 
            {{"wordCount": int, "sentiment": string, "suggestions": [string]}}
            
            Text to analyze: {text}"""
            
            response = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": "You are a marketing expert who analyzes product descriptions and provides actionable feedback."},
                    {"role": "user", "content": prompt}
                ],
                max_tokens=200,
                temperature=0.3
            )
            
            result_text = response.choices[0].message.content.strip()
            
            # Parse JSON from response
            import re
            json_match = re.search(r'({[\s\S]*})', result_text)
            if json_match:
                json_str = json_match.group(1)
                try:
                    result = json.loads(json_str)
                    return jsonify({"analysis": result})
                except json.JSONDecodeError:
                    print("Failed to parse JSON from OpenAI response")
        
        except Exception as e:
            print(f"Error using OpenAI for text analysis: {str(e)}")
            # Fall back to simple analysis
        
        # Simple text analysis fallback
        word_count = len(text.split())
        
        suggestions = []
        
        if word_count < 20:
            suggestions.append("Consider adding more details to your description.")
        
        if "!" not in text:
            suggestions.append("Adding excitement with exclamation marks can increase engagement!")
        
        common_buzzwords = ["premium", "quality", "luxury", "exclusive", "limited", "special"]
        if not any(word in text.lower() for word in common_buzzwords):
            suggestions.append("Consider adding compelling buzzwords like 'premium' or 'exclusive'.")
        
        sentiment = "positive" if len([w for w in ["great", "good", "excellent", "amazing"] if w in text.lower()]) > 0 else "neutral"
        
        return jsonify({
            "analysis": {
                "wordCount": word_count,
                "sentiment": sentiment,
                "suggestions": suggestions
            }
        })
    
    except Exception as e:
        print(f"Error analyzing text: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500
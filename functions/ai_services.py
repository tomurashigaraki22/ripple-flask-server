from flask import Blueprint, request, jsonify
import requests
import os
import json
import base64
from io import BytesIO
from PIL import Image
import numpy as np
from extensions.extensions import get_db_connection
import openai

ai_services_bp = Blueprint("ai_services", __name__)

# Configure OpenAI API key from environment variable
OPENAI_API_KEY = os.environ.get("OPENAI_API_KEY", "")
openai.api_key = OPENAI_API_KEY

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
        log_ai_estimation(image_url, title, description, dimensions, weight)
        
        return jsonify({
            "dimensions": dimensions,
            "weight": weight
        })
    
    except Exception as e:
        print(f"Error in dimension estimation: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

def estimate_from_image_ai(image_data, title="", description=""):
    """
    Estimate dimensions and weight from image data using OpenAI's Vision API
    """
    try:
        # Convert image to base64 for OpenAI API
        img = Image.open(BytesIO(image_data))
        buffered = BytesIO()
        img.save(buffered, format="JPEG")
        img_str = base64.b64encode(buffered.getvalue()).decode('utf-8')
        
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
        
        # Call OpenAI API with image
        response = openai.chat.completions.create(
            model="gpt-4-vision-preview",
            messages=[
                {
                    "role": "user",
                    "content": [
                        {"type": "text", "text": prompt},
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/jpeg;base64,{img_str}"
                            }
                        }
                    ]
                }
            ],
            max_tokens=300
        )
        
        # Extract the response text
        result_text = response.choices[0].message.content
        
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
                print("Failed to parse JSON from OpenAI response")
        
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

@ai_services_bp.route("/generate-description", methods=["POST"])
def generate_description():
    """Generate product description based on image and basic info using OpenAI"""
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "No data provided"}), 400
        
        image_url = data.get('imageUrl')
        title = data.get('title', '')
        category = data.get('category', '')
        
        # If OpenAI API key is available, use it to generate description
        if OPENAI_API_KEY:
            try:
                # Download the image if URL is provided
                img_str = None
                if image_url:
                    response = requests.get(image_url)
                    if response.status_code == 200:
                        img = Image.open(BytesIO(response.content))
                        buffered = BytesIO()
                        img.save(buffered, format="JPEG")
                        img_str = base64.b64encode(buffered.getvalue()).decode('utf-8')
                
                # Create messages for OpenAI API
                messages = [
                    {
                        "role": "user",
                        "content": [
                            {"type": "text", "text": f"Write a compelling product description for this {category} product titled '{title}'. Keep it under 100 words, highlight key features, and make it engaging for potential buyers."}
                        ]
                    }
                ]
                
                # Add image if available
                if img_str:
                    messages[0]["content"].append({
                        "type": "image_url",
                        "image_url": {
                            "url": f"data:image/jpeg;base64,{img_str}"
                        }
                    })
                
                # Call OpenAI API
                response = openai.chat.completions.create(
                    model="gpt-4-vision-preview" if img_str else "gpt-4",
                    messages=messages,
                    max_tokens=200
                )
                
                description = response.choices[0].message.content
                return jsonify({"description": description})
                
            except Exception as e:
                print(f"Error using OpenAI for description: {str(e)}")
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
    """Analyze product text to suggest improvements"""
    try:
        data = request.get_json()
        if not data or 'text' not in data:
            return jsonify({"error": "No text provided"}), 400
        
        text = data['text']
        
        # If OpenAI API key is available, use it for text analysis
        if OPENAI_API_KEY:
            try:
                response = openai.chat.completions.create(
                    model="gpt-4",
                    messages=[
                        {
                            "role": "system", 
                            "content": "You are a product listing expert. Analyze the provided product description and provide feedback."
                        },
                        {
                            "role": "user", 
                            "content": f"Analyze this product description and provide word count, sentiment analysis (positive, neutral, negative), and 2-3 specific suggestions for improvement. Return ONLY a JSON object with format: {{\"wordCount\": int, \"sentiment\": string, \"suggestions\": [string]}}\n\nText to analyze: {text}"
                        }
                    ],
                    max_tokens=300
                )
                
                result_text = response.choices[0].message.content
                
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
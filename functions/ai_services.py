from flask import Blueprint, request, jsonify
import requests
import os
import json
import base64
from io import BytesIO
from PIL import Image
import openai
import numpy as np
from extensions.extensions import get_db_connection
import google.generativeai as genai
from openai import OpenAI

ai_services_bp = Blueprint("ai_services", __name__)

# Configure Gemini API key (hardcoded as requested)
GEMINI_API_KEY = "AIzaSyBrEffEkJw_KFY2XDHWRt0B3jmobfLmAQE"
genai.configure(api_key=GEMINI_API_KEY)

# Configure OpenAI client (only if API key is available)
try:
    openai_api_key = os.getenv("OPENAI_API_KEY")
    if openai_api_key:
        openai_client = OpenAI(api_key=openai_api_key)
    else:
        openai_client = None
        print("Warning: OPENAI_API_KEY not set. OpenAI features will be disabled.")
except Exception as e:
    openai_client = None
    print(f"Warning: Failed to initialize OpenAI client: {str(e)}")

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
        Analyze this product image and estimate its physical dimensions (length, width, height in centimeter) 
        and weight (in kilogram). 
        
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
            # Use OpenAI for text analysis (only if client is available)
            if openai_client is None:
                raise Exception("OpenAI client not available")
                
            prompt = f"""Analyze this product description and provide:
            1. Word count
            2. Sentiment analysis (positive, neutral, negative)
            3. 2-3 specific suggestions for improvement
            
            Return ONLY a JSON object with format: 
            {{"wordCount": int, "sentiment": string, "suggestions": [string]}}
            
            Text to analyze: {text}"""
            
            response = openai_client.chat.completions.create(
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

@ai_services_bp.route("/pickup-address-suggestions", methods=["POST"])
def get_pickup_address_suggestions():
    """Get pickup location suggestions using Gemini"""
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "No data provided"}), 400
        
        # Extract location parameters
        country = data.get('country', '')
        state = data.get('state', '')
        city = data.get('city', '')
        street = data.get('street', '')
        
        # Validate required fields
        if not all([country, state, city, street]):
            return jsonify({"error": "Missing required fields: country, state, city, street"}), 400
        
        try:
            # Create prompt for Gemini based on country
            if country.lower() in ['usa', 'united states', 'us']:
                # For US addresses, look for USPS and UPS locations
                prompt = f"""Find the closest USPS Priority Mail and UPS pickup locations to this address:
                Street: {street}
                City: {city}
                State: {state}
                Country: {country}
                
                Please provide 3-5 nearby pickup locations that accept packages. Include:
                - USPS Post Offices and Priority Mail locations
                - UPS Stores and pickup points
                - FedEx locations
                
                Include the following information for each location:
                - Location name/type (Post Office, UPS Store, FedEx Office, etc.)
                - Full address
                - Distance from the given address (approximate)
                - Operating hours (if known)
                - Phone number (if available)
                
                Return ONLY a JSON object with the following format:
                {{
                    "pickup_locations": [
                        {{
                            "name": "string",
                            "address": "string",
                            "distance": "string",
                            "hours": "string",
                            "phone": "string"
                        }}
                    ]
                }}"""
            else:
                # For international addresses, look for local postal services and courier services
                prompt = f"""Find the closest postal service and courier pickup locations to this address:
                Street: {street}
                City: {city}
                State: {state}
                Country: {country}
                
                Please provide 3-5 nearby pickup locations for shipping packages internationally. Include:
                - Local postal service offices (like NIPOST for Nigeria)
                - International courier services (FedEx, UPS)
                - Global Post service points
                - Other shipping service providers
                
                Include the following information for each location:
                - Location name/type (Post Office, Global Post Service Point, etc.)
                - Full address
                - Distance from the given address (approximate)
                - Operating hours (if known)
                - Phone number (if available)
                - Services offered (international shipping, express delivery, etc.)
                
                Return ONLY a JSON object with the following format:
                {{
                    "pickup_locations": [
                        {{
                            "name": "string",
                            "address": "string",
                            "distance": "string",
                            "hours": "string",
                            "phone": "string",
                            "services": "string"
                        }}
                    ]
                }}"""
            
            # Set up the Gemini model
            model = genai.GenerativeModel('gemini-2.5-flash')
            
            # Call Gemini API
            response = model.generate_content(prompt)
            
            result_text = response.text
            print(f"Gemini response: {result_text}")  # Debug log
            
            # Parse JSON from response
            import re
            json_match = re.search(r'({[\s\S]*})', result_text)
            if json_match:
                json_str = json_match.group(1)
                try:
                    result = json.loads(json_str)
                    
                    # Add carrier_id to each pickup location based on the service type
                    if 'pickup_locations' in result:
                        for location in result['pickup_locations']:
                            location['carrier_id'] = determine_carrier_id(location.get('name', ''))
                    
                    # Log the request for analytics
                    try:
                        log_pickup_suggestion_request(country, state, city, street, result)
                    except Exception as e:
                        print(f"Warning: Could not log pickup suggestion request: {str(e)}")
                    
                    return jsonify(result)
                except json.JSONDecodeError as e:
                    print(f"Failed to parse JSON from Gemini response: {e}")
                    print(f"Raw response: {result_text}")
                    return jsonify({"error": "Failed to parse AI response"}), 500
            else:
                print(f"No JSON found in response: {result_text}")
                return jsonify({"error": "Invalid response format from AI"}), 500
                
        except Exception as e:
            print(f"Error using Gemini for pickup suggestions: {str(e)}")
            # Fallback to generic suggestions
            return get_fallback_pickup_suggestions(country, state, city, street)
    
    except Exception as e:
        print(f"Error getting pickup address suggestions: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

def determine_carrier_id(location_name):
    """Determine carrier_id based on location name/type"""
    location_name_lower = location_name.lower()
    
    # FedEx related - se-3051224
    if any(keyword in location_name_lower for keyword in ['fedex', 'fed ex', 'red star express']):
        return 'se-3051224'
    
    # UPS or USPS related - se-3051222  
    elif any(keyword in location_name_lower for keyword in ['ups', 'usps', 'post office', 'postal', 'nipost']):
        return 'se-3051222'
    
    # Global Post related - se-3051223 (including DHL since we can't control Gemini completely)
    elif any(keyword in location_name_lower for keyword in ['global post', 'globalpost', 'dhl', 'aramex']):
        return 'se-3051223'
    
    # Default to USPS/UPS carrier for unknown services
    else:
        return 'se-3051222'

def get_fallback_pickup_suggestions(country, state, city, street):
    """Fallback pickup suggestions when AI service is unavailable"""
    try:
        if country.lower() in ['usa', 'united states', 'us']:
            # US-specific fallback locations
            fallback_locations = [
                {
                    "name": f"{city} Main Post Office",
                    "address": f"Main Street, {city}, {state}",
                    "distance": "1-3 miles",
                    "hours": "Monday-Friday: 9:00 AM - 5:00 PM, Saturday: 9:00 AM - 1:00 PM",
                    "phone": "Call 1-800-ASK-USPS for local number",
                    "carrier_id": "se-3051222"
                },
                {
                    "name": f"{city} Post Office Branch",
                    "address": f"Downtown {city}, {state}",
                    "distance": "2-4 miles", 
                    "hours": "Monday-Friday: 9:00 AM - 5:00 PM",
                    "phone": "Call 1-800-ASK-USPS for local number",
                    "carrier_id": "se-3051222"
                },
                {
                    "name": "UPS Store (USPS Services)",
                    "address": f"Shopping Center, {city}, {state}",
                    "distance": "1-5 miles",
                    "hours": "Monday-Friday: 8:00 AM - 7:00 PM, Saturday: 9:00 AM - 5:00 PM",
                    "phone": "Contact local UPS Store",
                    "carrier_id": "se-3051222"
                }
            ]
        else:
            # International fallback locations
            fallback_locations = [
                {
                    "name": f"{city} Main Post Office",
                    "address": f"Central {city}, {state}, {country}",
                    "distance": "2-5 km",
                    "hours": "Monday-Friday: 8:00 AM - 4:00 PM",
                    "phone": "Contact local postal service",
                    "services": "International shipping, express delivery",
                    "carrier_id": "se-3051222"
                },
                {
                    "name": "Global Post Service Point",
                    "address": f"Commercial District, {city}, {state}",
                    "distance": "3-7 km",
                    "hours": "Monday-Friday: 9:00 AM - 6:00 PM, Saturday: 9:00 AM - 2:00 PM",
                    "phone": "Contact Global Post customer service",
                    "services": "International express delivery",
                    "carrier_id": "se-3051223"
                },
                {
                    "name": "FedEx Office",
                    "address": f"Business Area, {city}, {state}",
                    "distance": "2-6 km",
                    "hours": "Monday-Friday: 8:00 AM - 7:00 PM",
                    "phone": "Contact FedEx customer service",
                    "services": "International shipping, document services",
                    "carrier_id": "se-3051224"
                }
            ]
        
        return jsonify({
            "pickup_locations": fallback_locations,
            "note": "These are generic suggestions. Please verify locations and hours before visiting."
        })
        
    except Exception as e:
        print(f"Error in fallback pickup suggestions: {str(e)}")
        return jsonify({"error": "Unable to provide pickup suggestions"}), 500

def log_pickup_suggestion_request(country, state, city, street, suggestions):
    """Log pickup suggestion requests to database for tracking and analytics"""
    try:
        conn = get_db_connection()
        if not conn:
            print("Warning: No database connection available")
            return
            
        cursor = conn.cursor()
        
        # Create table if it doesn't exist
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS pickup_suggestion_requests (
                id INT AUTO_INCREMENT PRIMARY KEY,
                country VARCHAR(100),
                state VARCHAR(100),
                city VARCHAR(100),
                street VARCHAR(255),
                suggestions_count INT,
                suggestions JSON,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        """)
        conn.commit()
        
        # Insert the request data
        suggestions_count = len(suggestions.get('pickup_locations', []))
        cursor.execute("""
            INSERT INTO pickup_suggestion_requests 
            (country, state, city, street, suggestions_count, suggestions, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, NOW())
        """, (
            country, 
            state, 
            city, 
            street, 
            suggestions_count,
            json.dumps(suggestions)
        ))
        
        conn.commit()
        cursor.close()
        conn.close()
        
    except Exception as e:
        print(f"Error logging pickup suggestion request: {str(e)}")
        # Don't raise the exception as this is just logging
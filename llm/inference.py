import requests
import json
from django.conf import settings

def generate(prompt, max_tokens=250):
    """
    Calls OpenRouter API to generate a response for the given prompt.
    """
    if not prompt or not prompt.strip():
        raise ValueError("Prompt cannot be empty")

    api_key = getattr(settings, "OPENROUTER_API_KEY", None)
    model = getattr(settings, "OPENROUTER_MODEL", "deepseek/deepseek-chat")
    
    if not api_key:
        raise RuntimeError("OPENROUTER_API_KEY not found in settings.py")

    url = "https://openrouter.ai/api/v1/chat/completions"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
        "HTTP-Referer": "http://localhost:8000", # Optional, for OpenRouter analytics
        "X-Title": "POPC Healthcare App",         # Optional
    }

    payload = {
        "model": model,
        "messages": [
            {"role": "user", "content": prompt}
        ],
        "max_tokens": max_tokens,
        "temperature": 0.3
    }

    try:
        response = requests.post(url, headers=headers, data=json.dumps(payload), timeout=120)
        response.raise_for_status()
        
        result_json = response.json()
        if "choices" in result_json and len(result_json["choices"]) > 0:
            return result_json["choices"][0]["message"]["content"].strip()
        else:
            raise ValueError(f"Unexpected response structure from OpenRouter: {result_json}")

    except requests.exceptions.RequestException as e:
        error_msg = str(e)
        if e.response is not None:
             try:
                 error_msg = e.response.json().get('error', {}).get('message', str(e))
             except:
                 error_msg = e.response.text
        print(f"ERROR [OpenRouter]: {error_msg}")
        raise RuntimeError(f"OpenRouter Error: {error_msg}")
    except Exception as e:
        print(f"ERROR [Inference]: {str(e)}")
        raise e

import requests

url = "http://localhost:8000/chat"

prompt = "Erzähl mir etwas über Athena."
max_tokens = 512
temperature = 0.7

response = requests.post(url, json={
    "prompt": prompt,
    "max_tokens": max_tokens,
    "temperature": temperature
})

print(response.json())
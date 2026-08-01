from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn

# 1. Server instanziieren (statt Flask)
app = FastAPI(title="Mein Llama Backend")

# 2. Datenstruktur definieren (Das ist Pydantic)
# FastAPI blockt automatisch jeden Request ab, der nicht so aussieht!
class ChatRequest(BaseModel):
    prompt: str
    max_tokens: int = 512
    temperature: float = 0.7

# 3. Die Route (beachte das "async")
@app.post("/chat")
async def chat_with_llama(request: ChatRequest):
    
    # Hier würde später llama-cpp-python aufgerufen werden
    # z.B.: output = llm(request.prompt, max_tokens=request.max_tokens)
    
    fake_response = f"Simulierte Llama-Antwort auf: {request.prompt}"
    
    # Du gibst einfach ein Dictionary zurück, FastAPI macht JSON daraus
    return {
        "text": fake_response,
        "tokens_used": 15
    }

if __name__ == "__main__":
    # Server starten (Uvicorn ist der Standard-Server für FastAPI)
    uvicorn.run(app, host="127.0.0.1", port=8000)
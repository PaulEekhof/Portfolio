from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Optional
import uvicorn
import time
import requests

app = FastAPI()

# Ollama API configuration
OLLAMA_API_URL = "http://localhost:11434/api/generate"

class Message(BaseModel):
    role: str
    content: str

class ChatRequest(BaseModel):
    model: str
    messages: List[Message]
    max_tokens: Optional[int] = 1024
    temperature: Optional[float] = 0.7

@app.post("/v1/chat/completions")
async def chat_completion(request: ChatRequest):
    try:
        if not request.messages:
            raise HTTPException(status_code=400, detail="No messages provided")

        # Prepare the conversation history
        conversation = ""
        for msg in request.messages:
            conversation += f"{msg.role}: {msg.content}\n"
        conversation += "assistant: "

        # Call Ollama API
        ollama_request = {
            "model": "deepseek-r1:14b",
            "prompt": conversation,
            "stream": False,
            "options": {
                "temperature": request.temperature,
                "num_predict": request.max_tokens
            }
        }

        response = requests.post(OLLAMA_API_URL, json=ollama_request)
        if response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ollama API error")
            
        response_json = response.json()

        return {
            "id": f"chatcmpl-{int(time.time())}",
            "object": "chat.completion",
            "created": int(time.time()),
            "model": request.model,
            "choices": [{
                "message": {
                    "role": "assistant",
                    "content": response_json["response"].strip()
                },
                "finish_reason": "stop",
                "index": 0
            }]
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Model error: {str(e)}")

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
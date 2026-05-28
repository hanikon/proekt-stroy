from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.v1.routes import auth, users, dashboard, chat, files

app = FastAPI(title="ПроектСтрой API", version="0.1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router,       prefix="/api/v1/auth",      tags=["auth"])
app.include_router(users.router,      prefix="/api/v1/users",     tags=["users"])
app.include_router(dashboard.router,  prefix="/api/v1/dashboard", tags=["dashboard"])
app.include_router(chat.router,       prefix="/api/v1/chat",      tags=["chat"])
app.include_router(files.router,      prefix="/api/v1/files",     tags=["files"])

@app.get("/")
def root():
    return {"status": "ok", "app": "ПроектСтрой API v0.1.0"}

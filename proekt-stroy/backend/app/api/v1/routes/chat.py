from fastapi import APIRouter

router = APIRouter()

# TODO: реализовать маршруты модуля chat
@router.get("/")
def index():
    return {"module": "chat", "status": "placeholder"}

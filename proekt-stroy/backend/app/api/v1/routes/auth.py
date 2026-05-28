from fastapi import APIRouter

router = APIRouter()

# TODO: реализовать маршруты модуля auth
@router.get("/")
def index():
    return {"module": "auth", "status": "placeholder"}

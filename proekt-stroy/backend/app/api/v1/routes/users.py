from fastapi import APIRouter

router = APIRouter()

# TODO: реализовать маршруты модуля users
@router.get("/")
def index():
    return {"module": "users", "status": "placeholder"}

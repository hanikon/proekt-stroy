from fastapi import APIRouter

router = APIRouter()

# TODO: реализовать маршруты модуля dashboard
@router.get("/")
def index():
    return {"module": "dashboard", "status": "placeholder"}

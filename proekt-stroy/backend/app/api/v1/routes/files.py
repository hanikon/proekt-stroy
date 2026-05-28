from fastapi import APIRouter

router = APIRouter()

# TODO: реализовать маршруты модуля files
@router.get("/")
def index():
    return {"module": "files", "status": "placeholder"}

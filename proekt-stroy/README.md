# ПроектСтрой

Корпоративное веб-приложение для отдела проектирования строительной компании.

## Стек
- **Frontend**: React 18 + Vite + Tailwind CSS
- **Backend**: Python FastAPI
- **БД / Auth**: Supabase (PostgreSQL)

## Структура
```
proekt-stroy/
├── frontend/     React приложение
├── backend/      FastAPI сервер
└── docs/         SQL схема, документация
```

## Запуск

### Frontend
```bash
cd frontend && npm install && npm run dev
```

### Backend
```bash
cd backend
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

## Ветки
- `main`        — продакшн
- `dev`         — разработка
- `feature/*`   — новые фичи
- `fix/*`       — исправления

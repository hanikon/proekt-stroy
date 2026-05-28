-- ================================================
-- СХЕМА БД: ПроектСтрой
-- Запускается в Supabase SQL Editor
-- ================================================

-- Роли: admin | manager | designer | viewer
CREATE TABLE public.profiles (
  id          UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email       TEXT UNIQUE NOT NULL,
  full_name   TEXT,
  role        TEXT NOT NULL DEFAULT 'viewer'
              CHECK (role IN ('admin','manager','designer','viewer')),
  avatar_url  TEXT,
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- Проекты компании
CREATE TABLE public.projects (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name        TEXT NOT NULL,
  description TEXT,
  status      TEXT DEFAULT 'active' CHECK (status IN ('active','completed','archived')),
  created_by  UUID REFERENCES public.profiles(id),
  created_at  TIMESTAMPTZ DEFAULT now(),
  updated_at  TIMESTAMPTZ DEFAULT now()
);

-- Данные дашборда (этапы проектирования)
CREATE TABLE public.dashboard_entries (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  project_id  UUID REFERENCES public.projects(id) ON DELETE CASCADE,
  stage       TEXT NOT NULL,   -- концепция / эскиз / рабочий / согласование
  value       NUMERIC NOT NULL,
  label       TEXT,
  entered_by  UUID REFERENCES public.profiles(id),
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- Чаты (личные и групповые)
CREATE TABLE public.chats (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name        TEXT,
  is_group    BOOLEAN DEFAULT FALSE,
  created_by  UUID REFERENCES public.profiles(id),
  created_at  TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE public.chat_members (
  chat_id UUID REFERENCES public.chats(id) ON DELETE CASCADE,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  PRIMARY KEY (chat_id, user_id)
);

CREATE TABLE public.messages (
  id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  chat_id    UUID REFERENCES public.chats(id) ON DELETE CASCADE,
  sender_id  UUID REFERENCES public.profiles(id),
  content    TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Row Level Security (RLS)
ALTER TABLE public.profiles          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.projects          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dashboard_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.chats             ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages          ENABLE ROW LEVEL SECURITY;

-- Политики
CREATE POLICY "Профили видны авторизованным"
  ON public.profiles FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY "Только свой профиль можно менять"
  ON public.profiles FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Записи дашборда видны авторизованным"
  ON public.dashboard_entries FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY "Добавлять данные могут designer и выше"
  ON public.dashboard_entries FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM public.profiles
            WHERE id = auth.uid() AND role IN ('admin','manager','designer'))
  );

CREATE POLICY "Сообщения видны участникам чата"
  ON public.messages FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.chat_members
            WHERE chat_id = messages.chat_id AND user_id = auth.uid())
  );

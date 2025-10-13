CREATE DATABASE blog;

\connect blog

CREATE TABLE public.nodes (
  id           BIGSERIAL PRIMARY KEY,
  parent_id    BIGINT REFERENCES public.nodes(id) ON DELETE SET NULL,
  name         TEXT NOT NULL,
  path         TEXT NOT NULL,
  sort         INTEGER NOT NULL DEFAULT 0,
  visible      BOOLEAN NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT nodes_path_unique UNIQUE (path)
);

CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_nodes_set_updated_at
BEFORE UPDATE ON public.nodes
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

-- 實用索引
CREATE INDEX idx_nodes_parent_id ON public.nodes(parent_id);
CREATE INDEX idx_nodes_visible ON public.nodes(visible);
CREATE INDEX idx_nodes_sort ON public.nodes(sort);

-- 範例資料（可留可刪）
INSERT INTO public.nodes (name, path, sort, visible)
VALUES
  ('Root', '/root', 0, TRUE),
  ('Articles', '/root/articles', 10, TRUE),
  ('Drafts', '/root/drafts', 20, FALSE);

-- 把 Articles 設成 Root 的子節點
UPDATE public.nodes AS c
SET parent_id = p.id
FROM public.nodes AS p
WHERE c.path = '/root/articles' AND p.path = '/root';

UPDATE public.nodes AS c
SET parent_id = p.id
FROM public.nodes AS p
WHERE c.path = '/root/drafts' AND p.path = '/root';
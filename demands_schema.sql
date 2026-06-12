-- Script para criar a tabela de demandas (Kanban)
CREATE TABLE IF NOT EXISTS demands (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    status TEXT NOT NULL DEFAULT 'NOVA DEMANDA',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Ativando Row Level Security (RLS)
ALTER TABLE demands ENABLE ROW LEVEL SECURITY;

-- Como o sistema atual não possui autenticação ativada de forma estrita, 
-- permitiremos operações públicas na tabela (como nas outras tabelas do sistema).
CREATE POLICY "Permitir leitura pública em demands"
  ON demands FOR SELECT
  USING (true);

CREATE POLICY "Permitir inserção pública em demands"
  ON demands FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Permitir atualização pública em demands"
  ON demands FOR UPDATE
  USING (true);

CREATE POLICY "Permitir exclusão pública em demands"
  ON demands FOR DELETE
  USING (true);

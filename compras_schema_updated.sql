-- LIMPAR DADOS EXISTENTES
TRUNCATE supplier_items, suppliers RESTART IDENTITY;

-- HABILITAR RLS
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_items ENABLE ROW LEVEL SECURITY;

-- POLÍTICAS DE ACESSO
DROP POLICY IF EXISTS "Allow public read-only access" ON suppliers;
DROP POLICY IF EXISTS "Allow public read-only access" ON supplier_items;
DROP POLICY IF EXISTS "Allow public insert access" ON suppliers;
DROP POLICY IF EXISTS "Allow public insert access" ON supplier_items;

CREATE POLICY "Allow public read-only access" ON suppliers FOR SELECT USING (true);
CREATE POLICY "Allow public read-only access" ON supplier_items FOR SELECT USING (true);
CREATE POLICY "Allow public insert access" ON suppliers FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public insert access" ON supplier_items FOR INSERT WITH CHECK (true);

-- INSERIR FORNECEDORES E PRODUTOS COM CÓDIGOS (SKU)
DO $$
DECLARE
    sup_id UUID;
BEGIN
    -- 1. ADELAIDE MEGRATRON
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('ADELAIDE MEGRATRON', '5546999120000', 'Guaraciaba', 'Matriz', 'Cabos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'CABO LAN CAT5E', 'CAB-CAT5-01'), 
    (sup_id, 'CABO LAN CAT6', 'CAB-CAT6-02'), 
    (sup_id, 'FILTRO DE LINHA 5 TOMADAS', 'FL-05');

    -- 2. AMANDA DISCONE
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('AMANDA DISCONE', '5549988000000', 'Guaraciaba', 'Matriz', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'MHDX 3116', 'DVR-3116'), 
    (sup_id, 'BATERIA 12V 7A', 'BAT-127'), 
    (sup_id, 'SENSOR IVP', 'SENS-IVP');

    -- 9. YAMADA / INTELBRAS
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('YAMADA / INTELBRAS', '5545999330000', 'Toledo', 'Palotina', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'CENTRAL ANM 24 NET', 'INT-ANM24'), 
    (sup_id, 'SENSOR IVP 3000 PET', 'INT-3000P'), 
    (sup_id, 'BATERIA 12V 7A', 'BAT-127-INT');

    -- E-COMMERCE (Telefone = URL)
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Shopee - Conetcts Rapido', 'https://shopee.com.br/shop/529739', 'Online', 'Ecommerce', 'Ecommerce') RETURNING id INTO sup_id;
    
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Mercado Livre - Cabo Paralelo', 'https://www.mercadolivre.com.br/p/MLB20605768', 'Online', 'Ecommerce', 'Ecommerce') RETURNING id INTO sup_id;

END $$;

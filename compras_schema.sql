-- TABELA DE FORNECEDORES
CREATE TABLE IF NOT EXISTS suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    phone TEXT,
    city TEXT,
    region TEXT,
    category TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- TABELA DE PRODUTOS POR FORNECEDOR
CREATE TABLE IF NOT EXISTS supplier_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    supplier_id UUID REFERENCES suppliers(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- HABILITAR RLS (OPCIONAL MAS RECOMENDADO)
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read-only access" ON suppliers FOR SELECT USING (true);
CREATE POLICY "Allow public read-only access" ON supplier_items FOR SELECT USING (true);

-- INSERIR DADOS INICIAIS (BASEADO NA PLANILHA)

DO $$
DECLARE
    sup_id UUID;
BEGIN
    -- ADELAIDE MEGRATRON
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('ADELAIDE MEGRATRON', '5546999121212', 'Guaraciaba', 'Matriz', 'Cabos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'CABO LAN CAT5E'), (sup_id, 'CABO LAN CAT6'), (sup_id, 'CABO CCI 2 PARES');

    -- AMANDA DISCONE
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('AMANDA DISCONE', '5546988232323', 'Guaraciaba', 'Matriz', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'MHK 3116 - GRAVADOR DIGITAL'), (sup_id, 'BATERIA SELADA 12V 7A'), (sup_id, 'SENSOR INFRAVERMELHO IVP');

    -- AMARELO PRODETECH
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('AMARELO PRODETECH', '5546999454545', 'Francisco Beltrão', 'Matriz', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'CENTRAL DE ALARME MONITORADA'), (sup_id, 'TECLADO LCD PARA ALARME');

    -- CRISTIANO ALMEIDA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('CRISTIANO ALMEIDA', '5546999676767', 'Guaraciaba', 'Matriz', 'Parafuso') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'PARAFUSO 3.5X40MM'), (sup_id, 'PARAFUSO 4X50MM'), (sup_id, 'BUCHA 6 COM ABA');

    -- EP DISTRIBUIDORA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('EP DISTRIBUIDORA', '5546999898989', 'São Miguel do Oeste', 'Matriz', 'Materiais Diversos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'ESCADA ALUMÍNIO 7 DEGRAUS'), (sup_id, 'ABRAÇADEIRA NYLON 200MM');

    -- MAZER DISTRIBUIDORA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('MAZER DISTRIBUIDORA', '5546999111111', 'Guaraciaba', 'Matriz', 'Equipamentos Eletrônicos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'SSD 240GB KINGSTON'), (sup_id, 'SSD 480GB SANDISK'), (sup_id, 'HD 1TB WD PURPLE');

    -- PAUTA DISTRIBUIÇÃO
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('PAUTA DISTRIBUIÇÃO', '5546999222222', 'Guaraciaba', 'Matriz', 'Equipamentos Eletrônicos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'SSD 240GB WD GREEN'), (sup_id, 'HD 2TB WD PURPLE'), (sup_id, 'NOBREAK 600VA SMS');

    -- YAMADA / INTELBRAS
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('YAMADA / INTELBRAS', '5545999333333', 'Toledo', 'Palotina', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'CENTRAL DE ALARME ANM 24 NET'), (sup_id, 'SENSOR IVP 3000 PET'), (sup_id, 'BATIRA 12V 7A INTELBRAS');

    -- MERCADO LIVRE / SHOPEE
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('MERCADO LIVRE - CABO PARALELO', '00000000000', 'Online', 'Ecommerce', 'Cabos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'Link: Cabo Paralelo 2x1.5mm');

END $$;

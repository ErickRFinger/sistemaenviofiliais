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
    sku TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- HABILITAR RLS
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_items ENABLE ROW LEVEL SECURITY;

-- POLÍTICAS
DROP POLICY IF EXISTS "Allow public read-only access" ON suppliers;
DROP POLICY IF EXISTS "Allow public read-only access" ON supplier_items;
DROP POLICY IF EXISTS "Allow public insert access" ON suppliers;
DROP POLICY IF EXISTS "Allow public insert access" ON supplier_items;

CREATE POLICY "Allow public read-only access" ON suppliers FOR SELECT USING (true);
CREATE POLICY "Allow public read-only access" ON supplier_items FOR SELECT USING (true);
CREATE POLICY "Allow public insert access" ON suppliers FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public insert access" ON supplier_items FOR INSERT WITH CHECK (true);

-- LIMPAR TUDO
TRUNCATE supplier_items, suppliers RESTART IDENTITY;

-- INSERIR DADOS DA PLANILHA
DO $$
DECLARE
    sup_id UUID;
BEGIN
    -- 1. ADELAIDE MEGRATRON
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('ADELAIDE MEGRATRON', '5511999513891', 'Guaraciaba', 'Matriz', 'Cabos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'BOB CABO LAN F/UTP CAT5E 4X24 AWG CMX 500 M PT', '010706B0500PT00'),
    (sup_id, 'BOB CABO ULTRA CFTV 4PX24 AWG CCA 300 M BR', '010801B0300BR00'),
    (sup_id, 'CABO COAXIAL RF 0,4/2,5 + 2X26 AWG 300 M BR', '010106B0300BR00'),
    (sup_id, 'FILTRO DE LINHA 05 TOMADAS PR PP CIRCULAR 3X0,75X1,00M SACO PLASTICO', '012903S0100PT00'),
    (sup_id, 'FILTRO DE LINHA 06 TOMADAS PR PP CIRCULAR 3X0,75X1,00M SACO PLASTICO', '012904S0100PT00');

    -- 2. AMANDA DISCFONE
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('AMANDA DISCFONE', '5549991790952', 'Guaraciaba', 'Matriz', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'MHDX 1116-C - GRAVADOR DIGITAL DE VIDEO COMPACTO - 16 CANAIS + 02 IP ADICIONAIS - 1080P LITE', '4580776'),
    (sup_id, 'MHDX 1108 - GRAVADOR DIGITAL DE VIDEO (8 CANAIS)', '[VERIFICAR CÓDIGO]'),
    (sup_id, 'MHDX 1104 - GRAVADOR DIGITAL DE VIDEO (4 CANAIS)', '[VERIFICAR CÓDIGO]'),
    (sup_id, 'CABO OPTICO DROP 1KM CFOA C-BLI A/B-CM-01-FO-CO-LSZH PRETO', '4830162'),
    (sup_id, 'CABO OPTICO DROP MRGACABO S 2KM 1FO SM - MONOMODO EXT 1,0MM', '4441001'),
    (sup_id, 'CABO DE ALARME CCI 2P 0,5 MM CMX MULTICORES BC CAIXA 100M - CONDUTTI', '4441590'),
    (sup_id, 'CABO DE ALARME CCI 2P 0,5 MM CMX MULTICORES 100% COBRE BC CAIXA 100M - CONDUTTI', '4442147'),
    (sup_id, 'CENTRAL DE ALARME CONTRA ROUBO INTELBRAS ANM 24 NET', '4543512'),
    (sup_id, 'SENSOR MAGNETICO XAS 4010 SMART', '4540040'),
    (sup_id, 'CONTROLE REMOTO XAC 4000 SMART CONTROL PRETO', '4540005'),
    (sup_id, 'SIRENE 105 DB SIR 1000 - BRANCA', '4543544'),
    (sup_id, 'BATERIA ELETRICA VRLA CHUMBO 12V 4,5AH XB 12SEG', '4860010'),
    (sup_id, 'BATERIA ELETRICA VRLA CHUMBO 12V 5,6AH XB 12AL', '4821001'),
    (sup_id, 'SENSOR IVP 5001 PET EA', '4541012'),
    (sup_id, 'DETECTOR DE FUMACA CONVENCIONAL UNIVERSAL DFC 421 UN', '4610425'),
    (sup_id, 'TRANSMISSOR UNIVERSAL TX 4020 SMART', '4541024');

    -- 3. AMAURI YES MOCELIN
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('AMAURI YES MOCELIN', '554625206431', 'Francisco Beltrão', 'Beltrão', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'CENTRAL DE ALARME CONTRA ROUBO INTELBRAS ANM 24 NET', '4543512'),
    (sup_id, 'BATERIA VRLA 12V - XB 12SEG', '4860010'),
    (sup_id, 'BATERIA UNIPOWER 12V ALARME', '06K168'),
    (sup_id, 'XB 12AL-BATERIA VRLA 12V', '4821001'),
    (sup_id, 'SIRENE 105 dB SIR 1000 - BRANCA', '4543544'),
    (sup_id, 'SENSOR INFRAVERMELHO PASSIVO S/FIO IVP 1000 PET SF', '4541072'),
    (sup_id, 'SENSOR DE MOVIMENTO C/FIO IVP 1000 PET', '4541071'),
    (sup_id, 'SENSOR MAGNETICO XAS 4010 SMART', '4540040'),
    (sup_id, 'CONTROLE REMOTO XAC 4000 SMART CONTROL PRETO', '4540005'),
    (sup_id, 'CONTROLE REMOTO XAC 2000 TX PRETO', '4390170'),
    (sup_id, 'BOB CABO ULTRA CFTV 4PX24AWG CCA DC 300M PT', '30000065'),
    (sup_id, 'CABO BLINDADO EXTERNO (DC) 4PX24AWG COBRE PR 300M', '210801101');

    -- 4. CRISTIANO ALMEIDA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('CRISTIANO ALMEIDA', '5546999797072', 'Guaraciaba', 'Matriz', 'Parafusos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'PARAFUSO 3.5x30mm', 'PF-3530'),
    (sup_id, 'PARAFUSO 4x20mm', 'PF-4020'),
    (sup_id, 'PARAFUSO 4x40mm', 'PF-4040');

    -- 7. JP DISTRIBUIDORA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('JP DISTRIBUIDORA', '5511916478922', 'São Miguel do Oeste', 'Matriz', 'Materiais Diversos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'ESCADA ALUMINIO 7 DEGRAUS - ALUMASA', '3032'),
    (sup_id, 'APLICADOR DE SILICONE ABERTO 9"', '11800'),
    (sup_id, 'SILICONE MULTIFLEX BASE D AGUA 430G BRANCO - AFIX', '5994'),
    (sup_id, 'ABRACADEIRA NYLON 3,6X300MM BRANCA C/100 UN - JOFORT', '11783');

    -- 8. MAZER DISTRIBUIDORA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('MAZER DISTRIBUIDORA', '5549999285677', 'Guaraciaba', 'Matriz', 'Equipamentos Eletrônicos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'SSD 240GB WDGREEN OU SANDISK', 'SSD-240'),
    (sup_id, 'SSD 480GB WDGREEN OU SANDISK', 'SSD-480'),
    (sup_id, 'HD 1TB WD PURPLE', 'HD-1TB'),
    (sup_id, 'HD 2TB WD PURPLE', 'HD-2TB');

    -- 12. VARLEI
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('VARLEI', '5549991222487', 'Guaraciaba', 'Matriz', 'DVRs e SSDs') RETURNING id INTO sup_id;

    -- E-COMMERCE
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Shopee - Conector Rápido', 'https://br.shp.ee/3P7EPYE', 'Online', 'Ecommerce', 'Ecommerce') RETURNING id INTO sup_id;

    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Mercado Livre - Cabo Paralelo', 'https://www.mercadolivre.com.br/p/MLB29605766', 'Online', 'Ecommerce', 'Ecommerce') RETURNING id INTO sup_id;

    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Mercado Livre - Tomadas', 'https://www.mercadolivre.com.br/up/MLBU1466129880', 'Online', 'Ecommerce', 'Ecommerce') RETURNING id INTO sup_id;

END $$;

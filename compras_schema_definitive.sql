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
DROP POLICY IF EXISTS "Allow public delete access" ON supplier_items;

CREATE POLICY "Allow public read-only access" ON suppliers FOR SELECT USING (true);
CREATE POLICY "Allow public read-only access" ON supplier_items FOR SELECT USING (true);
CREATE POLICY "Allow public insert access" ON suppliers FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public insert access" ON supplier_items FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public delete access" ON supplier_items FOR DELETE USING (true);

-- LIMPAR TUDO
TRUNCATE supplier_items, suppliers RESTART IDENTITY;

-- INSERIR DADOS COMPLETOS
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
    (sup_id, 'CABO DE ALARME CCI 2P 0,5 MM CMX MULTICORES 100% COBRE BC CAIXA 100M', '4442147');

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
    (sup_id, 'BOB CABO ULTRA CFTV 4PX24AWG CCA DC 300M', '30000065');

    -- 4. CRISTIANO ALMEIDA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('CRISTIANO ALMEIDA', '5546999797072', 'Guaraciaba', 'Matriz', 'Parafusos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'PARAFUSO 3.5x30mm', 'PF-3530'),
    (sup_id, 'PARAFUSO 4x20mm', 'PF-4020'),
    (sup_id, 'PARAFUSO 4x40mm', 'PF-4040');

    -- 5. EDSON
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('EDSON', '5513996968947', 'Guaraciaba', 'Matriz', 'Fontes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'FONTES ELIZABETH', 'FONT-ELIZ');

    -- 6. FRAPA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('FRAPA', '5511916478922', 'Guaraciaba', 'Matriz', 'Cabos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'CABOS', 'CAB-FRAP');

    -- 7. JP DISTRIBUIDORA (DADOS CORRIGIDOS DA PLANILHA)
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('JP DISTRIBUIDORA', '5549999285677', 'São Miguel do Oeste', 'Matriz', 'Materiais Diversos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'ESCADA ALUMINIO 7 DEGRAUS - ALUMASA', '3032'),
    (sup_id, 'ESCADA EXTENSIVA ALUMINIO 11X2 DEGRAUS - MOR', '6473'),
    (sup_id, 'APLICADOR DE SILICONE ABERTO 9" - JOFORT', '11800'),
    (sup_id, 'SILICONE MULTIFLEX BASE D AGUA 430G BRANCO - AFIX', '5994'),
    (sup_id, 'ABRACADEIRA NYLON 3,6X300MM BRANCA C/100 UN - JOFORT', '11783'),
    (sup_id, 'ABRACADEIRA NYLON 3,6X300MM PRETA C/100 UN - JOFORT', '11784'),
    (sup_id, 'GRAMPO RIFIX P/ CORDAO 2,5MM 10-12 C/15 UN C/ PREGO - RIBEIRO', '6193'),
    (sup_id, 'ABRACADEIRA NYLON 4,8X300MM BRANCA C/100 UN - JOFORT', '11787'),
    (sup_id, 'ABRACADEIRA NYLON 4,8X300MM PRETA C/100 UN - JOFORT', '11788');

    -- 8. MAZER DISTRIBUIDORA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('MAZER DISTRIBUIDORA', '555121012177', 'Guaraciaba', 'Matriz', 'Equipamentos Eletrônicos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'SSD 240GB WDGREEN OU SANDISK', 'SSD-240'),
    (sup_id, 'SSD 480GB WDGREEN OU SANDISK', 'SSD-480'),
    (sup_id, 'HD 1TB WD PURPLE', 'HD-1TB'),
    (sup_id, 'HD 2TB WD PURPLE', 'HD-2TB');

    -- 9. MATHEUS DIGISEG
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('MATHEUS DIGISEG', '5546999800022', 'Pato Branco', 'Beltrão', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'CABO CFTV 4MM + 2PX26 AWG 100M FAST CAM FC67CBR', '4830053'),
    (sup_id, 'CABO CFTV 4MM + 2PX26 AWG 100M FAST CAM FC80CBR', '4830052'),
    (sup_id, 'COAXIAL RF 4MM 80% LIGA COBRE + BIP EXTERNO BR 100 (TELECAM)', '200604901'),
    (sup_id, 'CENTRAL DE ALARME ANTIFURTO - ANM24 NET', '4543512'),
    (sup_id, 'SIRENE 105 DB SIR 1000 - BRANCA', '4543544'),
    (sup_id, 'BATERIA VRLA 12V- XB 12SEG', '4860010'),
    (sup_id, 'SENSOR INFRAVERMELHO PASSIVO S/FIO IVP 1000 PET SF', '4541072'),
    (sup_id, 'SENSOR MAGNETICO XAS4010 SMART', '4540040');

    -- 10. PAUTA DISTRIBUIÇÃO
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('PAUTA DISTRIBUIÇÃO', '558004040000', 'Guaraciaba', 'Matriz', 'Equipamentos Eletrônicos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'SSD 240GB WDGREEN OU SANDISK', 'SSD-240'),
    (sup_id, 'SSD 480GB WDGREEN OU SANDISK', 'SSD-480'),
    (sup_id, 'HD 1TB WD PURPLE', 'HD-1TB'),
    (sup_id, 'HD 2TB WD PURPLE', 'HD-2TB'),
    (sup_id, 'NOBREAK 600VA SMS', '600VA-SMS'),
    (sup_id, 'NOBREAK 1200VA SMS', '1200VA-SMS');

    -- 11. THAYRINE
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('THAYRINE', '5548991350245', 'Guaraciaba', 'Matriz', 'Fontes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'FONTES', 'FONT-THAY');

    -- 12. THIARA TWG
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('THIARA TWG', '5511983467045', 'Guaraciaba', 'Matriz', 'Conectores') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'CONECTOR BNC', 'BNC-TWG'),
    (sup_id, 'CONECTOR P4', 'P4-TWG');

    -- 13. VARLEI
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('VARLEI', '5549991222487', 'Guaraciaba', 'Matriz', 'DVRs e SSDs') RETURNING id INTO sup_id;

    -- 14. YES MOCELIN TOLEDO
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('YES MOCELIN TOLEDO', '554520380008', 'Toledo', 'Palotina', 'Alarmes') RETURNING id INTO sup_id;
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
    (sup_id, 'BOB CABO ULTRA CFTV 4PX24AWG CCA DC 300M', '30000065');

    -- 15. CATITECH
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('CATITECH', '5514981236074', 'Guaraciaba', 'Matriz', 'RJs45') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'RJ45', 'RJ45-CATI');

    -- 16. RIBEIRO FABRIL
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('RIBEIRO FABRIL', '5519971342947', 'Guaraciaba', 'Matriz', 'Miguelão de Buchas') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'CARTUCHO MIGUELAO DE MADEIRA', 'MIG-MAD'),
    (sup_id, 'CARTUCHO MIGUELAO DE CONCRETO', 'MIG-CONC'),
    (sup_id, 'BUCHA 6', 'BUCHA-6');

    -- 17. ALINE - VOLTZ
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('ALINE - VOLTZ', '5544988240755', 'Guaraciaba', 'Matriz', 'Caixas Metálicas') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'QUADRO COMANDO MASTER 400X300X150 20/20/18', 'QM-403015'),
    (sup_id, 'QUADRO COMANDO MASTER 500X400X150 20/20/18', 'QM-504015'),
    (sup_id, 'QUADRO COMANDO MASTER 400X300X200 20/2018/', 'QM-403020'),
    (sup_id, 'QUADRO COMANDO MASTER 500X400X200 20/20/18', 'QM-504020'),
    (sup_id, 'QUADRO COMANDO MASTER 600X400X200 20/20/18', 'QM-604020');

    -- 18. GILTAR
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('GILTAR', '5547997592570', 'Guaraciaba', 'Matriz', 'CAIXINHAS DE PASSAGEM') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'CX-1001 B CAIXA DE PASSAGEM EM PP BRANCA', 'CX-1001-B');

    -- SHOPEE / MERCADO LIVRE
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Shopee - Conector Rápido', 'https://br.shp.ee/3P7EPYE', 'Online', 'Shopee', 'Conectores') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'Kit 100 Conector Rápido de Emenda Fio Elétrico com Alavanca 4mm 02 vias Dupla Saída', 'K100-CR');

    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Mercado Livre - Cabo Paralelo', 'https://www.mercadolivre.com.br/p/MLB29605766', 'Online', 'Mercado Livre', 'Cabos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'Cabo Paralelo Duplo 2x2 5mm 100m Maxtop Instalação Elétrica', 'PAR-2X25');

    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Mercado Livre - Kit Poe', 'https://www.mercadolivre.com.br/p/MLB37720474', 'Online', 'Mercado Livre', 'Conectores') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'Kit 10 Cabo Adaptador Poe Injetor + Separador', 'KIT-POE');

    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Mercado Livre - Tomadas', 'https://www.mercadolivre.com.br/up/MLBU1466129880', 'Online', 'Mercado Livre', 'Materiais Diversos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, 'Kit Com 50 Tomadas Tripla Em Barra 10a/20a Prismatec', 'KIT-TOM');

    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Mercado Livre - CX Organizadora', 'https://www.mercadolivre.com.br/up/MLBU1443414333', 'Online', 'Mercado Livre', 'Materiais Diversos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name, sku) VALUES 
    (sup_id, '20x Caixa Proteção Sobrepor Organizadora Cftv Stilus 2505', 'CX-STILUS');

END $$;

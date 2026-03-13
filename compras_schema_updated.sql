-- LIMPAR DADOS EXISTENTES PARA EVITAR DUPLICIDADE SE EXECUTADO NOVAMENTE
TRUNCATE supplier_items, suppliers RESTART IDENTITY;

-- HABILITAR RLS (OPCIONAL MAS RECOMENDADO)
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_items ENABLE ROW LEVEL SECURITY;

-- POLÍTICAS DE ACESSO (PERMITIR LEITURA E INSERÇÃO PÚBLICA PARA ESTE CASO)
CREATE POLICY "Allow public read-only access" ON suppliers FOR SELECT USING (true);
CREATE POLICY "Allow public read-only access" ON supplier_items FOR SELECT USING (true);
CREATE POLICY "Allow public insert access" ON suppliers FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public insert access" ON supplier_items FOR INSERT WITH CHECK (true);

-- INSERIR DADOS INICIAIS (BASEADO NA PLANILHA COMPRAS VIGI)

DO $$
DECLARE
    sup_id UUID;
BEGIN
    -- ADELAIDE MEGRATRON
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('ADELAIDE MEGRATRON', '5546999121212', 'Guaraciaba', 'Matriz', 'Cabos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES 
    (sup_id, 'CABO LAN CAT5E 4PARES'), (sup_id, 'CABO LAN CAT6 4PARES'), (sup_id, 'CABO CCI 2 PARES'), 
    (sup_id, 'FILTRO DE LINHA 5 TOMADAS'), (sup_id, 'QUADRO DE COMANDO 40X30X20');

    -- AMANDA DISCONE
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('AMANDA DISCONE', '5546988232323', 'Guaraciaba', 'Matriz', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES 
    (sup_id, 'MHK 3116 - GRAVADOR DIGITAL'), (sup_id, 'BATERIA SELADA 12V 7A'), (sup_id, 'SENSOR INFRAVERMELHO IVP'),
    (sup_id, 'MHDX 1104 - GRAVADOR DIGITAL');

    -- AMARELO PRODETECH
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('AMARELO PRODETECH', '5546999454545', 'Francisco Beltrão', 'Matriz', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES 
    (sup_id, 'CENTRAL DE ALARME MONITORADA'), (sup_id, 'TECLADO LCD PARA ALARME'), (sup_id, 'BATERIA SELADA 12V 7A'),
    (sup_id, 'SIRENE 120DB BRANCA'), (sup_id, 'SENSOR MAGNÉTICO SEM FIO');

    -- CRISTIANO ALMEIDA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('CRISTIANO ALMEIDA', '5546999676767', 'Guaraciaba', 'Matriz', 'Parafuso') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES 
    (sup_id, 'PARAFUSO 3.5X40MM'), (sup_id, 'PARAFUSO 4X50MM'), (sup_id, 'BUCHA 6 COM ABA');

    -- ELIZABETE TRAPA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('ELIZABETE TRAPA', '5546999887766', 'Guaraciaba', 'Matriz', 'Cabos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'CABO COAXIAL FLEXIVEL'), (sup_id, 'CABO COAXIAL COM ALIMENTAÇÃO');

    -- EP DISTRIBUIDORA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('EP DISTRIBUIDORA', '5546999898989', 'São Miguel do Oeste', 'Matriz', 'Materiais Diversos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES 
    (sup_id, 'ESCADA ALUMÍNIO 7 DEGRAUS'), (sup_id, 'ABRAÇADEIRA NYLON 200MM (C/100)'), (sup_id, 'SILICONE ACÉTICO BRANCO'),
    (sup_id, 'ESTILETE PROFISSIONAL'), (sup_id, 'FITA ISOLANTE 20M');

    -- MAZER DISTRIBUIDORA
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('MAZER DISTRIBUIDORA', '5546999111111', 'Guaraciaba', 'Matriz', 'Equipamentos Eletrônicos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES 
    (sup_id, 'SSD 240GB KINGSTON'), (sup_id, 'SSD 480GB SANDISK'), (sup_id, 'HD 1TB WD PURPLE'),
    (sup_id, 'HD 2TB WD PURPLE'), (sup_id, 'MEMORIA DDR4 8GB');

    -- PAUTA DISTRIBUIÇÃO
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('PAUTA DISTRIBUIÇÃO', '5546999222222', 'Guaraciaba', 'Matriz', 'Equipamentos Eletrônicos') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES 
    (sup_id, 'SSD 240GB WD GREEN'), (sup_id, 'HD 2TB WD PURPLE'), (sup_id, 'NOBREAK 600VA SMS'),
    (sup_id, 'NOBREAK 1200VA SMS'), (sup_id, 'PLACA DE REDE GIGABIT');

    -- YAMADA / INTELBRAS
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('YAMADA / INTELBRAS', '5545999333333', 'Toledo', 'Palotina', 'Alarmes') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES 
    (sup_id, 'CENTRAL DE ALARME ANM 24 NET'), (sup_id, 'SENSOR IVP 3000 PET'), (sup_id, 'BATERIA 12V 7A INTELBRAS'),
    (sup_id, 'SIRENE 120DB PRETA'), (sup_id, 'CONTROLE REMOTO INTELBRAS');

    -- CATTI TECH
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('CATTI TECH', '5546999445566', 'Guaraciaba', 'Matriz', 'RJ45') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'PLUG RJ45 CAT5E (UN)'), (sup_id, 'PLUG RJ45 CAT6 (UN)');

    -- RIBEIRO FERRAGENS
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('RIBEIRO FERRAGENS', '5546999778899', 'Guaraciaba', 'Matriz', 'Buchas de Parede') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'BUCHA 6 COM ABA'), (sup_id, 'BUCHA 8 COM ABA'), (sup_id, 'CASTELHO SEXTAVADO');

    -- E-LETRO
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('E-LETRO', '5546999112233', 'Guaraciaba', 'Matriz', 'Caixinhas de Passagem') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'CP 150X150X80'), (sup_id, 'CP 100X100X50'), (sup_id, 'CP 200X200X100');

    -- ONLINE STORES
    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('SHopee - Conetcts Rapido', '00000000000', 'Online', 'Ecommerce', 'Ecommerce') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'https://shopee.com.br/product/123/456');

    INSERT INTO suppliers (name, phone, city, region, category) 
    VALUES ('Mercado Livre - Cabo Paralelo', '00000000000', 'Online', 'Ecommerce', 'Ecommerce') RETURNING id INTO sup_id;
    INSERT INTO supplier_items (supplier_id, name) VALUES (sup_id, 'https://www.mercadolivre.com.br/cabo-paralelo');

END $$;

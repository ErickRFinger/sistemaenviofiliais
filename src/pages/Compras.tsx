import { useState } from 'react';
import { Search, Building2, ShoppingBag, Phone } from 'lucide-react';

interface Supplier {
    name: string;
    city: string;
    region: string;
    category: string;
    phone: string;
}

const FORNECEDORES: Supplier[] = [
    { name: 'ADELAIDE MEGATRON', city: 'GUARACIABA', region: 'MATRIZ', category: 'CABOS', phone: '11999513891' },
    { name: 'ELIZABETH FRAPA', city: 'GUARACIABA', region: 'MATRIZ', category: 'CABOS', phone: '11916478922' },
    { name: 'JP DISTRIBUIDORA', city: 'SÃO MIGUEL DO OESTE', region: 'MATRIZ', category: 'MATERIAIS DIVERSOS', phone: '49999285677' },
    { name: 'ROSE AMPERMAX', city: 'GUARACIABA', region: 'MATRIZ', category: 'CONECTORES E ENERGIA', phone: '35997449517' },
    { name: 'THIARA TWG', city: 'GUARACIABA', region: 'MATRIZ', category: 'CONECTORES', phone: '11983467045' },
    { name: 'CRISTIANO ALMEIDA', city: 'GUARACIABA', region: 'MATRIZ', category: 'PARAFUSOS', phone: '46999797072' },
    { name: 'RIBEIRO FABRIL', city: 'GUARACIABA', region: 'MATRIZ', category: 'MIGUELÃO DE BUCHAS', phone: '19971342947' },
    { name: 'CATITECH', city: 'GUARACIABA', region: 'MATRIZ', category: 'RJS45', phone: '14981236074' },
    { name: 'YES MOCELIN TOLEDO', city: 'TOLEDO', region: 'PALOTINA', category: 'ALARMES', phone: '4520380008' },
    { name: 'AMAURI YES MOCELIN BELTRÃO', city: 'FRANCISCO BELTRÃO', region: 'BELTRÃO', category: 'ALARMES', phone: '4625206431' },
    { name: 'MATHEUS DIGISEG', city: 'PATO BRANCO', region: 'BELTRÃO', category: 'ALARMES', phone: '46999800022' },
    { name: 'ALEXSANDER DISCFONE', city: 'GUARACIABA', region: 'MATRIZ', category: 'ALARMES', phone: '49984024611' },
    { name: 'THAYRINE', city: 'GUARACIABA', region: 'MATRIZ', category: 'FONTES', phone: '48991350245' },
    { name: 'EDSON', city: 'GUARACIABA', region: 'MATRIZ', category: 'FONTES', phone: '13996968947' },
    { name: 'EZEQUIEL FERNANDES', city: 'GUARACIABA', region: 'MATRIZ', category: 'DVRS HIK', phone: '62984572752' },
    { name: 'RAMON BASCAM', city: 'GUARACIABA', region: 'MATRIZ', category: 'DVRS HIK', phone: '4931978162' },
    { name: 'TIAGO BASSO BASCAM', city: 'GUARACIABA', region: 'MATRIZ', category: 'DVRS HIK', phone: '49998188961' },
    { name: 'MAZER DISTRIBUIDORA', city: 'GUARACIABA', region: 'MATRIZ', category: 'EQUIPAMENTOS ELETRÔNICOS', phone: '5121012177' },
    { name: 'PAUTA DISTRIBUIÇÃO', city: 'GUARACIABA', region: 'MATRIZ', category: 'EQUIPAMENTOS ELETRÔNICOS', phone: '08004040000' },
    { name: 'VARLEI', city: 'GUARACIABA', region: 'MATRIZ', category: 'DVRS E SSDS', phone: '49991222487' },
    { name: 'RAFFAEL ROHDINA', city: 'GUARACIABA', region: 'MATRIZ', category: 'CAIXINHAS', phone: '4735141551' },
    { name: 'SUL STILUS', city: 'GUARACIABA', region: 'MATRIZ', category: 'CAIXINHAS', phone: '11914185245' },
    { name: 'GILTAR', city: 'GUARACIABA', region: 'MATRIZ', category: 'CAIXINHAS', phone: '47997592570' },
    { name: 'ALINE VOLTZ', city: 'GUARACIABA', region: 'MATRIZ', category: 'CAIXAS METÁLICAS', phone: '44988240755' },
    { name: 'KONEXTOP', city: 'GUARACIABA', region: 'MATRIZ', category: 'ELETRODUTO', phone: '4791727503' },
];

export default function Compras() {
    const [searchTerm, setSearchTerm] = useState('');
    
    const filteredSuppliers = FORNECEDORES.filter(supplier => {
        return supplier.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
               supplier.category.toLowerCase().includes(searchTerm.toLowerCase());
    });

    const handleWhatsApp = (phone: string) => {
        let cleanPhone = phone.replace(/\D/g, '');
        if (cleanPhone.length > 0 && !cleanPhone.startsWith('55')) {
            cleanPhone = '55' + cleanPhone;
        }
        window.open(`https://wa.me/${cleanPhone}?text=Ol%C3%A1%2C%20gostaria%20de%20consultar%20produtos.`, '_blank');
    };

    return (
        <div className="animate-fade-in" style={{ paddingBottom: '4rem' }}>
            <header style={{ marginBottom: '2.5rem' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '1.25rem' }}>
                    <div style={{ 
                        background: 'linear-gradient(135deg, rgba(249, 115, 22, 0.2), rgba(234, 88, 12, 0.4))', 
                        padding: '1rem', 
                        borderRadius: '16px', 
                        color: '#fb923c',
                        boxShadow: '0 8px 30px rgba(249, 115, 22, 0.2)',
                        border: '1px solid rgba(249, 115, 22, 0.2)'
                    }}>
                        <ShoppingBag size={28} />
                    </div>
                    <div>
                        <h2 style={{ fontSize: '2.25rem', fontWeight: '800', letterSpacing: '-0.025em', color: 'white' }}>
                            Fornecedores
                        </h2>
                        <p style={{ color: 'var(--text-secondary)', fontWeight: '500' }}>Catálogo de fornecedores e cotações.</p>
                    </div>
                </div>
            </header>

            <div className="glass-panel" style={{ padding: '2rem', marginBottom: '2.5rem' }}>
                <div>
                    <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '700', color: 'var(--text-secondary)', marginBottom: '0.75rem', textTransform: 'uppercase' }}>
                        Buscar Fornecedor ou Categoria
                    </label>
                    <div style={{ position: 'relative' }}>
                        <Search size={20} style={{ position: 'absolute', left: '1rem', top: '50%', transform: 'translateY(-50%)', color: 'var(--accent)' }} />
                        <input
                            type="text"
                            className="input-glass"
                            placeholder="Ex: Adelaide, Cabos, Alarmes..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            style={{ paddingLeft: '3rem', height: '54px', width: '100%', maxWidth: '400px' }}
                        />
                    </div>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '1.5rem' }}>
                {filteredSuppliers.map((supplier, idx) => (
                    <div key={idx} className="glass-panel" style={{ padding: '1.5rem', display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                            <div style={{ background: 'rgba(59, 130, 246, 0.1)', padding: '0.5rem', borderRadius: '10px', color: 'var(--accent)' }}>
                                <Building2 size={20} />
                            </div>
                            <div>
                                <h3 style={{ fontSize: '1.15rem', fontWeight: '700', color: 'white' }}>{supplier.name}</h3>
                            </div>
                        </div>

                        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.5rem' }}>
                            <span style={{ fontSize: '0.75rem', padding: '0.2rem 0.6rem', borderRadius: '6px', background: 'rgba(249, 115, 22, 0.14)', color: '#fb923c', fontWeight: '600', border: '1px solid rgba(249, 115, 22, 0.2)' }}>
                                {supplier.category}
                            </span>
                        </div>

                        <button
                            onClick={() => handleWhatsApp(supplier.phone)}
                            className="btn-primary"
                            style={{ 
                                marginTop: 'auto', 
                                width: '100%', 
                                height: '48px', 
                                background: 'linear-gradient(135deg, #10b981, #059669)',
                                boxShadow: '0 10px 20px rgba(16, 185, 129, 0.2)'
                            }}
                        >
                            <Phone size={18} />
                            Chamar no WhatsApp
                        </button>
                    </div>
                ))}
            </div>
        </div>
    );
}

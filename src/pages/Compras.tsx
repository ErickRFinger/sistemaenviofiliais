import { useState } from 'react';
import { suppliers } from '../data/suppliers';
import { Phone, MapPin, Package, Search, Building2, ShoppingBag } from 'lucide-react';

export default function Compras() {
    const [searchTerm, setSearchTerm] = useState('');
    const [selectedCity, setSelectedCity] = useState<string>('all');

    // Extract unique cities for filter
    const cities = ['all', ...new Set(suppliers.map(s => s.city))];

    const filteredSuppliers = suppliers.filter(supplier => {
        const matchesSearch =
            supplier.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
            supplier.product.toLowerCase().includes(searchTerm.toLowerCase());
        const matchesCity = selectedCity === 'all' || supplier.city === selectedCity;
        return matchesSearch && matchesCity;
    });

    const handleWhatsApp = (phone: string, product: string) => {
        const message = `Olá, gostaria de fazer um pedido de ${product}.`;
        window.open(`https://wa.me/${phone}?text=${encodeURIComponent(message)}`, '_blank');
    };

    return (
        <div className="animate-fade-in" style={{ paddingBottom: '4rem' }}>
            <header style={{ marginBottom: '2rem' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', marginBottom: '0.5rem' }}>
                    <div style={{ 
                        background: 'linear-gradient(135deg, rgba(249, 115, 22, 0.2), rgba(234, 88, 12, 0.4))', 
                        padding: '1rem', 
                        borderRadius: '16px', 
                        color: '#fb923c',
                        boxShadow: '0 8px 32px rgba(249, 115, 22, 0.15)',
                        border: '1px solid rgba(249, 115, 22, 0.2)'
                    }}>
                        <ShoppingBag size={28} />
                    </div>
                    <div>
                        <h2 style={{ fontSize: '2.25rem', fontWeight: '800', letterSpacing: '-0.025em', background: 'linear-gradient(to right, #fff, #94a3b8)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
                            Compras Premium
                        </h2>
                        <p style={{ color: 'var(--text-secondary)', fontWeight: '500' }}>Gestão de fornecedores e pedidos estratégicos.</p>
                    </div>
                </div>
            </header>

            {/* Filters & Search - Enhanced Glass */}
            <div className="glass-panel" style={{ 
                padding: '2rem', 
                marginBottom: '2.5rem', 
                background: 'rgba(255, 255, 255, 0.02)', 
                border: '1px solid rgba(255, 255, 255, 0.05)',
                boxShadow: '0 20px 50px rgba(0,0,0,0.3)'
            }}>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '2rem', alignItems: 'end' }}>
                    <div style={{ flex: 1 }}>
                        <label style={{ display: 'block', fontSize: '0.9rem', fontWeight: '600', color: 'var(--text-secondary)', marginBottom: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Buscar Fornecedor:</label>
                        <div style={{ position: 'relative' }}>
                            <Search size={20} style={{ position: 'absolute', left: '1.25rem', top: '50%', transform: 'translateY(-50%)', color: 'var(--accent)' }} />
                            <input
                                type="text"
                                className="input-glass"
                                placeholder="Nome, cabo, fonte, alarme..."
                                value={searchTerm}
                                onChange={(e) => setSearchTerm(e.target.value)}
                                style={{ 
                                    paddingLeft: '3.25rem', 
                                    height: '56px', 
                                    fontSize: '1rem',
                                    background: 'rgba(0,0,0,0.3)',
                                    borderColor: 'rgba(255,255,255,0.1)'
                                }}
                            />
                        </div>
                    </div>

                    <div>
                        <label style={{ display: 'block', fontSize: '0.9rem', fontWeight: '600', color: 'var(--text-secondary)', marginBottom: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Cidades:</label>
                        <div style={{ 
                            display: 'flex', 
                            gap: '0.75rem', 
                            overflowX: 'auto', 
                            paddingBottom: '0.75rem', 
                            scrollbarWidth: 'none',
                            msOverflowStyle: 'none'
                        }}>
                            {cities.map(city => (
                                <button
                                    key={city}
                                    onClick={() => setSelectedCity(city)}
                                    style={{
                                        padding: '0.75rem 1.5rem',
                                        borderRadius: '14px',
                                        fontSize: '0.9rem',
                                        fontWeight: '700',
                                        whiteSpace: 'nowrap',
                                        cursor: 'pointer',
                                        transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                                        background: selectedCity === city ? 'linear-gradient(135deg, var(--accent), #1d4ed8)' : 'rgba(255,255,255,0.03)',
                                        color: selectedCity === city ? 'white' : 'var(--text-secondary)',
                                        border: '1px solid ' + (selectedCity === city ? 'var(--accent)' : 'rgba(255,255,255,0.1)'),
                                        boxShadow: selectedCity === city ? '0 8px 20px rgba(59, 130, 246, 0.3)' : 'none',
                                        transform: selectedCity === city ? 'scale(1.05)' : 'scale(1)'
                                    }}
                                >
                                    {city === 'all' ? '🌎 Todas' : city}
                                </button>
                            ))}
                        </div>
                    </div>
                </div>
            </div>

            {/* Suppliers Grid - Vibrant Cards */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '2rem' }}>
                {filteredSuppliers.map((supplier) => (
                    <div key={supplier.id} className="glass-panel glass-card" style={{ 
                        padding: '2rem', 
                        display: 'flex', 
                        flexDirection: 'column', 
                        gap: '1.25rem',
                        position: 'relative',
                        overflow: 'hidden',
                        background: 'rgba(30, 41, 59, 0.4)'
                    }}>
                        {/* Decorative Gradient Blob */}
                        <div style={{ 
                            position: 'absolute', 
                            top: '-20px', 
                            right: '-20px', 
                            width: '100px', 
                            height: '100px', 
                            background: 'radial-gradient(circle, rgba(59, 130, 246, 0.1) 0%, transparent 70%)',
                            zIndex: 0
                        }} />

                        <div style={{ display: 'flex', alignItems: 'center', gap: '1.25rem', position: 'relative', zIndex: 1 }}>
                            <div style={{ 
                                background: 'linear-gradient(135deg, rgba(59, 130, 246, 0.2), rgba(37, 99, 235, 0.4))', 
                                padding: '0.75rem', 
                                borderRadius: '12px', 
                                color: '#60a5fa',
                                border: '1px solid rgba(59, 130, 246, 0.2)'
                            }}>
                                <Building2 size={24} />
                            </div>
                            <h3 style={{ fontSize: '1.25rem', fontWeight: '800', color: 'white', letterSpacing: '-0.01em' }}>{supplier.name}</h3>
                        </div>

                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem', marginTop: '0.5rem', position: 'relative', zIndex: 1 }}>
                            <div style={{ 
                                display: 'flex', 
                                alignItems: 'center', 
                                gap: '1rem', 
                                background: 'rgba(249, 115, 22, 0.05)', 
                                padding: '0.75rem 1rem', 
                                borderRadius: '12px',
                                border: '1px solid rgba(249, 115, 22, 0.1)'
                            }}>
                                <Package size={20} style={{ color: '#fb923c' }} />
                                <span style={{ fontWeight: '600', color: '#fed7aa', fontSize: '0.95rem' }}>{supplier.product}</span>
                            </div>

                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', color: 'var(--text-secondary)', paddingLeft: '0.5rem' }}>
                                <MapPin size={18} style={{ color: '#94a3b8' }} />
                                <span style={{ fontSize: '0.9rem', fontWeight: '500' }}>{supplier.city} • <span style={{ color: 'rgba(255,255,255,0.4)', fontSize: '0.8rem' }}>{supplier.region}</span></span>
                            </div>
                        </div>

                        <button
                            onClick={() => handleWhatsApp(supplier.phone, supplier.product)}
                            className="btn-primary"
                            style={{ 
                                marginTop: '1.5rem', 
                                width: '100%', 
                                height: '52px',
                                background: 'linear-gradient(135deg, #f97316, #ea580c)',
                                boxShadow: '0 10px 25px rgba(249, 115, 22, 0.4)',
                                fontSize: '1rem',
                                fontWeight: '700',
                                border: '1px solid rgba(255,255,255,0.1)',
                                position: 'relative',
                                zIndex: 1
                            }}
                        >
                            <Phone size={20} />
                            Fazer Pedido de Compra
                        </button>
                    </div>
                ))}
            </div>

            {filteredSuppliers.length === 0 && (
                <div className="glass-panel" style={{ padding: '6rem 2rem', textAlign: 'center', background: 'rgba(255,255,255,0.01)' }}>
                    <div style={{ 
                        width: '80px', 
                        height: '80px', 
                        background: 'rgba(255,255,255,0.03)', 
                        borderRadius: '50%', 
                        display: 'flex', 
                        alignItems: 'center', 
                        justifyContent: 'center', 
                        margin: '0 auto 1.5rem',
                        border: '1px solid rgba(255,255,255,0.05)'
                    }}>
                        <Search size={40} style={{ color: 'var(--text-secondary)', opacity: 0.4 }} />
                    </div>
                    <h3 style={{ fontSize: '1.5rem', fontWeight: '700' }}>Nenhum fornecedor encontrado</h3>
                    <p style={{ color: 'var(--text-secondary)', marginTop: '0.5rem', fontSize: '1.1rem' }}>Refine sua busca ou tente outra cidade.</p>
                </div>
            )}
        </div>
    );
}

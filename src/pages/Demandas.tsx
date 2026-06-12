import { useState, useEffect } from 'react';
import { supabase } from '../lib/supabase';
import { Plus, X, Loader2, ClipboardList, Clock, PlayCircle, CheckCircle2, MoreVertical, Trash2, ChevronLeft, ChevronRight } from 'lucide-react';

interface Demanda {
    id: string;
    title: string;
    description: string;
    status: 'NOVA DEMANDA' | 'PENDENTE' | 'EM PROCESSO' | 'FINALIZADA';
    created_at: string;
}

const COLUMNS = [
    { id: 'NOVA DEMANDA', label: 'Nova Demanda', icon: ClipboardList, color: '#3b82f6', bg: 'rgba(59, 130, 246, 0.1)' },
    { id: 'PENDENTE', label: 'Pendente', icon: Clock, color: '#f59e0b', bg: 'rgba(245, 158, 11, 0.1)' },
    { id: 'EM PROCESSO', label: 'Em Processo', icon: PlayCircle, color: '#8b5cf6', bg: 'rgba(139, 92, 246, 0.1)' },
    { id: 'FINALIZADA', label: 'Finalizada', icon: CheckCircle2, color: '#10b981', bg: 'rgba(16, 185, 129, 0.1)' },
] as const;

export default function Demandas() {
    const [demandas, setDemandas] = useState<Demanda[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [isSubmitting, setIsSubmitting] = useState(false);
    
    // Form states
    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');

    useEffect(() => {
        fetchDemandas();
    }, []);

    async function fetchDemandas() {
        setLoading(true);
        const { data, error } = await supabase
            .from('demands')
            .select('*')
            .order('created_at', { ascending: false });

        if (error) {
            console.error('Erro ao buscar demandas:', error);
        } else {
            setDemandas(data || []);
        }
        setLoading(false);
    }

    const handleCreate = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!title.trim()) return;

        setIsSubmitting(true);
        const { data, error } = await supabase
            .from('demands')
            .insert([{ title, description, status: 'NOVA DEMANDA' }])
            .select()
            .single();

        if (error) {
            alert('Erro ao criar demanda: ' + error.message);
        } else if (data) {
            setDemandas([data, ...demandas]);
            setIsModalOpen(false);
            setTitle('');
            setDescription('');
        }
        setIsSubmitting(false);
    };

    const handleDelete = async (id: string) => {
        if (!window.confirm('Tem certeza que deseja excluir esta demanda?')) return;
        
        setDemandas(demandas.filter(d => d.id !== id)); // Optimistic UI
        const { error } = await supabase.from('demands').delete().eq('id', id);
        if (error) {
            alert('Erro ao excluir: ' + error.message);
            fetchDemandas(); // Revert on error
        }
    };

    const moveCard = async (id: string, newStatus: string) => {
        setDemandas(prev => prev.map(d => d.id === id ? { ...d, status: newStatus as any } : d)); // Optimistic UI
        const { error } = await supabase.from('demands').update({ status: newStatus }).eq('id', id);
        if (error) {
            alert('Erro ao mover: ' + error.message);
            fetchDemandas(); // Revert on error
        }
    };

    return (
        <div className="animate-fade-in" style={{ paddingBottom: '4rem', height: '100%', display: 'flex', flexDirection: 'column' }}>
            <header style={{ marginBottom: '2rem' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '1rem' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '1.25rem' }}>
                        <div style={{ 
                            background: 'linear-gradient(135deg, rgba(139, 92, 246, 0.2), rgba(124, 58, 237, 0.4))', 
                            padding: '1rem', 
                            borderRadius: '16px', 
                            color: '#a78bfa',
                            boxShadow: '0 8px 30px rgba(139, 92, 246, 0.2)',
                            border: '1px solid rgba(139, 92, 246, 0.2)'
                        }}>
                            <ClipboardList size={28} />
                        </div>
                        <div>
                            <h2 style={{ fontSize: '2.25rem', fontWeight: '800', letterSpacing: '-0.025em', color: 'white' }}>
                                Demandas
                            </h2>
                            <p style={{ color: 'var(--text-secondary)', fontWeight: '500' }}>Quadro Kanban de tarefas e anotações.</p>
                        </div>
                    </div>
                    
                    <button 
                        onClick={() => setIsModalOpen(true)}
                        className="btn-primary"
                        style={{ background: 'linear-gradient(135deg, #8b5cf6, #6d28d9)', boxShadow: '0 10px 20px rgba(139, 92, 246, 0.3)' }}
                    >
                        <Plus size={20} />
                        Nova Demanda
                    </button>
                </div>
            </header>

            {loading ? (
                <div style={{ textAlign: 'center', padding: '4rem', flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <Loader2 size={40} className="animate-spin" style={{ color: 'var(--accent)' }} />
                </div>
            ) : (
                <div style={{ 
                    display: 'flex', 
                    gap: '1.5rem', 
                    overflowX: 'auto', 
                    paddingBottom: '1rem',
                    flex: 1,
                    alignItems: 'flex-start',
                    WebkitOverflowScrolling: 'touch'
                }}>
                    {COLUMNS.map((col, colIndex) => {
                        const colDemandas = demandas.filter(d => d.status === col.id);
                        return (
                            <div key={col.id} className="glass-panel" style={{ 
                                minWidth: '320px', 
                                width: '320px',
                                display: 'flex', 
                                flexDirection: 'column', 
                                maxHeight: 'calc(100vh - 200px)',
                                padding: '1rem'
                            }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '1.5rem', paddingBottom: '1rem', borderBottom: '1px solid var(--border)' }}>
                                    <div style={{ background: col.bg, padding: '0.5rem', borderRadius: '10px', color: col.color }}>
                                        <col.icon size={20} />
                                    </div>
                                    <h3 style={{ fontSize: '1.1rem', fontWeight: '700', color: 'white', flex: 1 }}>{col.label}</h3>
                                    <span style={{ background: 'rgba(255,255,255,0.1)', padding: '0.2rem 0.6rem', borderRadius: '20px', fontSize: '0.8rem', fontWeight: '700' }}>
                                        {colDemandas.length}
                                    </span>
                                </div>

                                <div style={{ overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: '1rem', flex: 1, paddingRight: '0.5rem' }}>
                                    {colDemandas.length === 0 ? (
                                        <div style={{ textAlign: 'center', padding: '2rem', opacity: 0.5, border: '1px dashed var(--border)', borderRadius: '12px' }}>
                                            <p style={{ fontSize: '0.85rem' }}>Nenhuma demanda</p>
                                        </div>
                                    ) : (
                                        colDemandas.map(demanda => (
                                            <div key={demanda.id} style={{
                                                background: 'rgba(255,255,255,0.03)',
                                                border: '1px solid rgba(255,255,255,0.08)',
                                                borderRadius: '14px',
                                                padding: '1.25rem',
                                                display: 'flex',
                                                flexDirection: 'column',
                                                gap: '0.75rem',
                                                boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
                                                transition: 'all 0.2s ease',
                                            }}>
                                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                                                    <h4 style={{ fontWeight: '600', color: 'white', fontSize: '1rem', lineHeight: '1.4' }}>
                                                        {demanda.title}
                                                    </h4>
                                                    <button 
                                                        onClick={() => handleDelete(demanda.id)}
                                                        style={{ background: 'none', border: 'none', color: 'var(--text-secondary)', cursor: 'pointer', padding: '0.2rem' }}
                                                    >
                                                        <Trash2 size={16} />
                                                    </button>
                                                </div>
                                                
                                                {demanda.description && (
                                                    <p style={{ fontSize: '0.85rem', color: 'var(--text-secondary)', lineHeight: '1.5', whiteSpace: 'pre-wrap' }}>
                                                        {demanda.description}
                                                    </p>
                                                )}

                                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '0.5rem', paddingTop: '0.75rem', borderTop: '1px solid rgba(255,255,255,0.05)' }}>
                                                    <span style={{ fontSize: '0.7rem', color: 'var(--text-secondary)' }}>
                                                        {new Date(demanda.created_at).toLocaleDateString('pt-BR')}
                                                    </span>
                                                    
                                                    <div style={{ display: 'flex', gap: '0.5rem' }}>
                                                        <button 
                                                            onClick={() => moveCard(demanda.id, COLUMNS[colIndex - 1].id)}
                                                            disabled={colIndex === 0}
                                                            style={{ 
                                                                background: colIndex === 0 ? 'rgba(255,255,255,0.02)' : 'rgba(255,255,255,0.1)', 
                                                                border: 'none', borderRadius: '6px', padding: '0.4rem', 
                                                                color: colIndex === 0 ? 'rgba(255,255,255,0.2)' : 'white', cursor: colIndex === 0 ? 'not-allowed' : 'pointer' 
                                                            }}
                                                        >
                                                            <ChevronLeft size={16} />
                                                        </button>
                                                        <button 
                                                            onClick={() => moveCard(demanda.id, COLUMNS[colIndex + 1].id)}
                                                            disabled={colIndex === COLUMNS.length - 1}
                                                            style={{ 
                                                                background: colIndex === COLUMNS.length - 1 ? 'rgba(255,255,255,0.02)' : 'rgba(255,255,255,0.1)', 
                                                                border: 'none', borderRadius: '6px', padding: '0.4rem', 
                                                                color: colIndex === COLUMNS.length - 1 ? 'rgba(255,255,255,0.2)' : 'white', cursor: colIndex === COLUMNS.length - 1 ? 'not-allowed' : 'pointer' 
                                                            }}
                                                        >
                                                            <ChevronRight size={16} />
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        ))
                                    )}
                                </div>
                            </div>
                        );
                    })}
                </div>
            )}

            {/* Modal Nova Demanda */}
            {isModalOpen && (
                <div style={{
                    position: 'fixed', top: 0, left: 0, right: 0, bottom: 0,
                    background: 'rgba(0,0,0,0.85)', backdropFilter: 'blur(10px)',
                    zIndex: 1000, display: 'flex', alignItems: 'center', justifyContent: 'center',
                    padding: '1rem'
                }}>
                    <div className="glass-panel animate-fade-in" style={{
                        width: '100%', maxWidth: '500px',
                        display: 'flex', flexDirection: 'column', overflow: 'hidden',
                        boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.5)',
                        border: '1px solid rgba(255,255,255,0.1)'
                    }}>
                        <div style={{ padding: '1.5rem', borderBottom: '1px solid var(--border)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <h3 style={{ fontSize: '1.25rem', fontWeight: '800', color: 'white' }}>Nova Demanda</h3>
                            <button onClick={() => setIsModalOpen(false)} style={{ background: 'rgba(255,255,255,0.05)', border: 'none', color: 'white', cursor: 'pointer', padding: '0.5rem', borderRadius: '50%' }}>
                                <X size={20} />
                            </button>
                        </div>

                        <form onSubmit={handleCreate} style={{ padding: '1.5rem', display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '700', color: 'var(--text-secondary)', marginBottom: '0.5rem' }}>Título da Tarefa *</label>
                                <input
                                    type="text"
                                    required
                                    className="input-glass"
                                    placeholder="Ex: Fazer pedido de conectores"
                                    value={title}
                                    onChange={(e) => setTitle(e.target.value)}
                                    style={{ width: '100%' }}
                                    autoFocus
                                />
                            </div>

                            <div>
                                <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '700', color: 'var(--text-secondary)', marginBottom: '0.5rem' }}>Detalhes (Opcional)</label>
                                <textarea
                                    className="input-glass"
                                    placeholder="Informações adicionais..."
                                    value={description}
                                    onChange={(e) => setDescription(e.target.value)}
                                    style={{ width: '100%', minHeight: '100px', resize: 'vertical' }}
                                />
                            </div>

                            <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
                                <button type="button" onClick={() => setIsModalOpen(false)} className="btn-secondary" style={{ flex: 1 }}>
                                    Cancelar
                                </button>
                                <button type="submit" disabled={isSubmitting || !title.trim()} className="btn-primary" style={{ flex: 1, background: 'linear-gradient(135deg, #8b5cf6, #6d28d9)' }}>
                                    {isSubmitting ? <Loader2 className="animate-spin" /> : 'Salvar'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            )}
        </div>
    );
}

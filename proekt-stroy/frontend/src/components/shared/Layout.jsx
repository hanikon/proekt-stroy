import { Outlet, NavLink } from 'react-router-dom'
import { useAuth } from '../../hooks/useAuth'

export default function Layout() {
  const { signOut } = useAuth()
  return (
    <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
      <nav style={{ display:'flex', alignItems:'center', gap:'1rem', padding:'0 1.5rem', height:'56px', borderBottom:'1px solid #e5e7eb', background:'#fff' }}>
        <span style={{ fontWeight:600, marginRight:'auto' }}>ПроектСтрой</span>
        <NavLink to="/">Дашборд</NavLink>
        <NavLink to="/chat">Чаты</NavLink>
        <NavLink to="/settings">Настройки</NavLink>
        <button onClick={signOut}>Выход</button>
      </nav>
      <main style={{ flex:1, padding:'1.5rem' }}>
        <Outlet />
      </main>
    </div>
  )
}

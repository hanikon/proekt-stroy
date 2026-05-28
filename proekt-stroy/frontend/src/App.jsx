import { Routes, Route, Navigate } from 'react-router-dom'
import { useAuth } from './hooks/useAuth'
import LoginPage    from './pages/LoginPage'
import DashboardPage from './pages/DashboardPage'
import ChatPage     from './pages/ChatPage'
import SettingsPage from './pages/SettingsPage'
import Layout       from './components/shared/Layout'

function PrivateRoute({ children }) {
  const { user, loading } = useAuth()
  if (loading) return <div style={{display:'flex',alignItems:'center',justifyContent:'center',height:'100vh'}}>Загрузка...</div>
  return user ? children : <Navigate to="/login" replace />
}

export default function App() {
  return (
    <Routes>
      <Route path="/login" element={<LoginPage />} />
      <Route path="/" element={<PrivateRoute><Layout /></PrivateRoute>}>
        <Route index element={<DashboardPage />} />
        <Route path="chat" element={<ChatPage />} />
        <Route path="settings" element={<SettingsPage />} />
      </Route>
    </Routes>
  )
}

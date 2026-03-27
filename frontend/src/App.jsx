import { useEffect, useState } from 'react'

function App() {
  const [data, setData] = useState(null)

  useEffect(() => {
    fetch('http://localhost:3000/health')
      .then((res) => res.json())
      .then((json) => setData(json))
      .catch((err) => console.error(err))
  }, [])

  return (
    <div>
      <h1>React + Rails</h1>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  )
}

export default App
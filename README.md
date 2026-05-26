MyFinz

Aplicación fullstack compuesta por:

Frontend en React + Redux Toolkit
Backend API en Ruby on Rails
Base de datos PostgreSQL
Backend dockerizado con Docker Compose
Control de versiones con Git + GitHub
📦 Stack Tecnológico
Frontend
React
Vite
Redux Toolkit
React Redux
Backend
Ruby on Rails API
PostgreSQL
Puma
DevOps
Docker
Docker Compose
📁 Estructura del Proyecto
MyFinz/
│
├── frontend/
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── vite.config.js
│
├── backend/
│   ├── app/
│   ├── config/
│   ├── db/
│   ├── Dockerfile
│   ├── compose.yaml
│   ├── Gemfile
│   └── ...
│
└── README.md
✅ Requisitos Previos

Instalar las siguientes herramientas:

1. Git

Descargar:
Git for Windows

Verificar instalación:

git --version
2. Node.js (LTS)

Descargar:
Node.js

Verificar instalación:

node -v
npm -v
3. Docker Desktop

Descargar:
Docker Desktop

IMPORTANTE:

Activar soporte WSL2 durante instalación
Reiniciar la PC si Docker lo solicita

Verificar instalación:

docker -v
docker compose version
🚀 Inicialización del Proyecto
1️⃣ Clonar repositorio
git clone <URL_DEL_REPO>
cd MyFinz
2️⃣ Inicializar Frontend

Entrar a la carpeta frontend:

cd frontend

Instalar dependencias:

npm install

Levantar servidor de desarrollo:

npm run dev

El frontend quedará disponible en:

http://localhost:5173
3️⃣ Inicializar Backend

Abrir otra terminal.

Entrar al backend:

cd backend

Construir contenedores:

docker compose build

Levantar backend y base de datos:

docker compose up

El backend quedará disponible en:

http://localhost:3000
🗄️ Base de Datos

El proyecto utiliza PostgreSQL dentro de Docker.

Configuración por defecto:

Variable	Valor
Usuario	postgres
Password	postgres
DB	myfinz_development
🔧 Comandos Útiles
Backend
Abrir consola Rails
docker compose exec backend bash
Ejecutar migraciones
docker compose exec backend rails db:migrate
Crear nueva migración
docker compose exec backend rails generate migration NombreMigracion
Crear modelo
docker compose exec backend rails generate model NombreModelo
Crear controlador
docker compose exec backend rails generate controller NombreControlador
Frontend
Instalar nueva dependencia
npm install nombre-paquete
Build producción
npm run build
🌐 Comunicación Frontend ↔ Backend

Frontend:

http://localhost:5173

Backend:

http://localhost:3000

Rails utiliza CORS para permitir comunicación entre ambos.

🧪 Endpoint de prueba

Backend:

GET /health

Respuesta esperada:

{
  "ok": true,
  "message": "Backend funcionando"
}
🐳 Docker
Levantar servicios
docker compose up
Levantar en background
docker compose up -d
Detener servicios
docker compose down
Rebuild completo
docker compose up --build
📄 Variables de Entorno
Backend

Crear archivo:

backend/.env

Ejemplo:

DATABASE_URL=postgres://postgres:postgres@db:5432/myfinz_development
RAILS_ENV=development
📌 Recomendaciones
Windows

Se recomienda:

Docker Desktop + WSL2
PowerShell o Git Bash
Evitar CMD clásico
🔥 Flujo de desarrollo recomendado
Terminal 1

Frontend:

cd frontend
npm run dev
Terminal 2

Backend:

cd backend
docker compose up
📚 Recursos útiles
React

React Documentation

Redux Toolkit

Redux Toolkit Documentation

Ruby on Rails

Ruby on Rails Guides

Docker

Docker Documentation

PostgreSQL

PostgreSQL Documentation

👨‍💻 Autor

Proyecto personal desarrollado con:

React
Redux Toolkit
Ruby on Rails
PostgreSQL
Docker

Proyecto: MyFinz
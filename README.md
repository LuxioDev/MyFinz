# MyFinz

#Inicializar proyecto:
backend
docker compose -f backend/compose.yaml up
frontend
npm run dev

Aplicación fullstack compuesta por:

- Frontend en React + Redux Toolkit
- Backend API en Ruby on Rails
- Base de datos PostgreSQL
- Backend dockerizado con Docker Compose
- Control de versiones con Git + GitHub

---

# 📦 Stack Tecnológico

## Frontend

- React
- Vite
- Redux Toolkit
- React Redux

## Backend

- Ruby on Rails API
- PostgreSQL
- Puma

## DevOps

- Docker
- Docker Compose

---

# 📁 Estructura del Proyecto

```text
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
```

---

# ✅ Requisitos Previos

Instalar las siguientes herramientas:

## 1. Git

Descargar:

https://git-scm.com/download/win

Verificar instalación:

```bash
git --version
```

---

## 2. Node.js (LTS)

Descargar:

https://nodejs.org/

Verificar instalación:

```bash
node -v
npm -v
```

---

## 3. Docker Desktop

Descargar:

https://www.docker.com/products/docker-desktop/

IMPORTANTE:

- Activar soporte WSL2 durante instalación
- Reiniciar la PC si Docker lo solicita

Verificar instalación:

```bash
docker -v
docker compose version
```

---

# 🚀 Inicialización del Proyecto

---

# 1️⃣ Clonar repositorio

```bash
git clone <URL_DEL_REPO>
cd MyFinz
```

---

# 2️⃣ Inicializar Frontend

Entrar a la carpeta frontend:

```bash
cd frontend
```

Instalar dependencias:

```bash
npm install
```

Levantar servidor de desarrollo:

```bash
npm run dev
```

El frontend quedará disponible en:

```text
http://localhost:5173
```

---

# 3️⃣ Inicializar Backend

Abrir otra terminal.

Entrar al backend:

```bash
cd backend
```

Construir contenedores:

```bash
docker compose build
```

Levantar backend y base de datos:

```bash
docker compose up
```

El backend quedará disponible en:

```text
http://localhost:3000
```

---

# 🗄️ Base de Datos

El proyecto utiliza PostgreSQL dentro de Docker.

Configuración por defecto:

| Variable | Valor |
|---|---|
| Usuario | postgres |
| Password | postgres |
| DB | myfinz_development |

---

# 🔧 Comandos Útiles

## Backend

### Abrir consola Rails

```bash
docker compose exec backend bash
```

### Ejecutar migraciones

```bash
docker compose exec backend rails db:migrate
```

### Crear nueva migración

```bash
docker compose exec backend rails generate migration NombreMigracion
```

### Crear modelo

```bash
docker compose exec backend rails generate model NombreModelo
```

### Crear controlador

```bash
docker compose exec backend rails generate controller NombreControlador
```

---

## Frontend

### Instalar nueva dependencia

```bash
npm install nombre-paquete
```

### Build producción

```bash
npm run build
```

---

# 🌐 Comunicación Frontend ↔ Backend

Frontend:

```text
http://localhost:5173
```

Backend:

```text
http://localhost:3000
```

Rails utiliza CORS para permitir comunicación entre ambos.

---

# 🧪 Endpoint de prueba

Backend:

```text
GET /health
```

Respuesta esperada:

```json
{
  "ok": true,
  "message": "Backend funcionando"
}
```

---

# 🐳 Docker

## Levantar servicios

```bash
docker compose up
```

## Levantar en background

```bash
docker compose up -d
```

## Detener servicios

```bash
docker compose down
```

## Rebuild completo

```bash
docker compose up --build
```

---

# 📄 Variables de Entorno

## Backend

Crear archivo:

```text
backend/.env
```

Ejemplo:

```env
DATABASE_URL=postgres://<USER>:<PASSWORD>@db:5432/<DATABASE_NAME>
RAILS_ENV=development
```

---

# 📌 Recomendaciones

## Windows

Se recomienda:

- Docker Desktop + WSL2
- PowerShell o Git Bash
- Evitar CMD clásico

---

# 🔥 Flujo de desarrollo recomendado

## Terminal 1

Frontend:

```bash
cd frontend
npm run dev
```

## Terminal 2

Backend:

```bash
cd backend
docker compose up
```

---

# 📚 Recursos útiles

## React

https://react.dev/

## Redux Toolkit

https://redux-toolkit.js.org/

## Ruby on Rails

https://guides.rubyonrails.org/

## Docker

https://docs.docker.com/

## PostgreSQL

https://www.postgresql.org/docs/

---

# 👨‍💻 Autor

Proyecto personal desarrollado con:

- React
- Redux Toolkit
- Ruby on Rails
- PostgreSQL
- Docker

Proyecto: **MyFinz**
# SmartInspect — Monitoring & Inspection Management

A college/demo implementation of a centralized monitoring platform for projects, institutes and NGOs. It includes a React frontend, Node.js/Express API, MySQL schema, JWT role-based authentication, random inspection assignment, CCTV registry, evidence upload, alerts, and optional n8n/Ollama integrations.

## 1. Requirements
- Windows 10/11
- Node.js 20+ recommended
- MySQL 8+ (or XAMPP MySQL)
- VS Code
- Optional: n8n and Ollama

## 2. Database
1. Start MySQL.
2. Open MySQL Workbench.
3. Run `database/schema.sql` completely.

## 3. Backend
Open a terminal:
```cmd
cd backend
npm install
copy .env.example .env
```
Open `.env` and set `DB_USER`, `DB_PASSWORD`, and other values if needed.

Create the admin:
```cmd
npm run create-admin
```
Defaults:
- Email: `admin@smartinspect.local`
- Password: `Admin@123`

Start API:
```cmd
npm run dev
```
API: http://localhost:5000

## 4. Frontend
Open a second terminal:
```cmd
cd frontend
npm install
npm run dev
```
Open the Vite URL, normally http://localhost:5173

Login with the admin credentials above.

## 5. Roles
- ADMIN: full demo administration
- DEPARTMENT_OFFICIAL: project/inspection/CCTV management
- INSPECTION_TEAM: inspection work and evidence
- PROJECT_INCHARGE: project-side role

To create another role, insert/update a user in MySQL or extend the admin-user script.

## 6. Evidence upload
Uploaded files are stored in `backend/uploads` and metadata is stored in MySQL.

## 7. Ollama
Install/start Ollama, then download a model, for example:
```cmd
ollama pull llama3.2:1b
```
Keep Ollama running. The backend uses `OLLAMA_URL` and `OLLAMA_MODEL` from `.env`. The inspection AI-summary endpoint is optional.

## 8. n8n
Import `n8n/smartinspect-alert-workflow.json` into n8n. Set the backend `N8N_WEBHOOK_URL` to the webhook URL shown by n8n. The backend sends events when inspections are created or randomly assigned. Add email/SMS/Teams nodes as needed.

## 9. Important scope note
CCTV URLs are stored and displayed as monitoring records; this starter does not bypass camera authentication or provide unauthorized access to real CCTV systems. For a real deployment, use an authorized video gateway/provider and secure credentials.

## 10. Project modules included
- Login/JWT authentication
- Role-based API permissions
- Dashboard metrics
- Project CRUD starter
- Routine/surprise/random inspections
- Random assignment to inspection team
- CCTV registry/status
- Evidence upload
- Alerts/resolution
- n8n webhook integration
- Ollama inspection summary hook

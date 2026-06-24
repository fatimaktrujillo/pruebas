# Configuración del Dashboard IJM

## Contraseña de acceso
```
IJM2026
```
Para cambiarla: genera el SHA-256 de la nueva contraseña en https://emn178.github.io/online-tools/sha256.html
y reemplaza `PASS_HASH` en `index.html` (línea ~120).

---

## Paso 1 — Subir al repositorio (una sola vez)

Abre una terminal (cmd o PowerShell) **dentro de esta carpeta** `dashboard_github` y ejecuta:

```bash
git init
git remote add origin https://github.com/fatimaktrujillo/pruebas.git
git add .
git commit -m "Primer deploy dashboard IJM"
git branch -M main
git push -u origin main
```

---

## Paso 2 — Activar GitHub Pages (una sola vez)

1. Ve a https://github.com/fatimaktrujillo/pruebas/settings/pages
2. En **Source** elige **GitHub Actions**
3. Guarda

El dashboard quedará publicado en:
**https://fatimaktrujillo.github.io/pruebas/**

---

## Paso 3 — Automatizar la subida de datos (una sola vez)

Clic derecho en `setup_tareas_programadas.ps1` → **Ejecutar con PowerShell** (como Administrador).

Esto crea dos tareas de Windows que corren automáticamente:
- **10:00 AM** — lee el Excel y sube el JSON a GitHub
- **05:00 PM** — ídem

Requisitos previos:
- Python con openpyxl instalado: `pip install openpyxl`
- Git configurado con acceso push al repo

---

## Actualización manual

Doble clic en `auto_push.bat` para forzar una actualización ahora.
El historial queda en `log_auto_push.txt`.

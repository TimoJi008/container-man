# ──────────────── Build-Stage ────────────────
FROM node:20.19.1-slim AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Produktion bauen, Ausgabe in /app/dist
RUN npm run build

# ───────────── Serve-Stage mit Nginx ─────────────
FROM nginx:alpine

# Statische Dateien aus der Build-Stage kopieren
COPY --from=build /app/dist/container-man /usr/share/nginx/html

# (Optional) Custom Nginx‐Config für Client‐Routing:
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# ─────────── Build-Stage ───────────
FROM node:20.19.1-slim AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Baue die Angular App (Output landet im default dist/<projectName>)
RUN npm run build -- --output-path=dist

# ──────── Serve-Stage mit 'serve' ────────
FROM node:20.19.1-slim

WORKDIR /app
# Installiere den Static-Server
RUN npm install -g serve

# Kopiere das gebaute Verzeichnis
COPY --from=build /app/dist /app/dist

# Railway setzt PORT – verwende ihn:
ENTRYPOINT ["sh", "-c", "serve -s /app/dist -l $PORT"]

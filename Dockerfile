# ─── Build-Stage ───
FROM node:20.19.1-slim AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build  # nutzt outputPath aus angular.json

# ─── Serve-Stage mit Nginx ───
FROM nginx:alpine

# 1) Leere das default-Verzeichnis
RUN rm -rf /usr/share/nginx/html/*

# 2) Kopiere nur die Build-Dateien (Achte auf den exakten outputPath!)
COPY --from=build /app/dist/container-man/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

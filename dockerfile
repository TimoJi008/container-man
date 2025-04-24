# Schritt 1: Bauen
FROM node:20.19.1-slim AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --output-path=dist

# Schritt 2: Als statische Seite mit nginx ausliefern
FROM nginx:alpine

# Kopiere gebaute Angular-Dateien in nginx public-Verzeichnis
COPY --from=build /app/dist /usr/share/nginx/html

# Entferne default nginx config (optional)
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

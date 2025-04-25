# ─── Build-Stage ───
FROM node:20.19.1-slim AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Force Angular to build into /app/dist
RUN npm run build -- --output-path=dist

# ─── Serve-Stage mit Nginx ───
FROM nginx:alpine
# Erst mal alle Standard-Dateien rausschmeißen
RUN rm -rf /usr/share/nginx/html/*

# Dann die gebauten Dateien hinein
COPY --from=build /app/dist/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

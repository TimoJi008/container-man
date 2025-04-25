# 1) Build
FROM node:20.19.1-slim AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --output-path=dist/browser

# 2) Serve mit "serve" auf Railway/Render
FROM node:20.19.1-slim
RUN npm install -g serve
COPY --from=build /app/dist/browser /app/dist
# Standard-Port, falls $PORT nicht gesetzt
ENV PORT=9000
ENTRYPOINT ["sh","-c","serve -s /app/dist -l ${PORT}"]

# Imagen del backend de SMRED (API Node.js + Express) para Render.
# Multi-stage build: la primera etapa instala dependencias, la segunda solo lleva lo necesario para ejecutar.

FROM node:22-alpine AS deps
WORKDIR /app
# No hace falta python3/make/g++: las dependencias son 100 % JavaScript (bcryptjs, tedious)
COPY package*.json ./
RUN npm ci --omit=dev

FROM node:22-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY --from=deps /app/node_modules ./node_modules
# --chown: el usuario node (sin privilegios) es dueño de los archivos, no root
COPY --chown=node:node . .
# El proceso no corre como root: si alguien lograra explotar la app, no controla el contenedor
USER node
EXPOSE 3000
# node directamente (no npm start): así recibe la señal de apagado y cierra la BD de forma ordenada
CMD ["node", "src/server.js"]

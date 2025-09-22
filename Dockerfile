# -------- Stage 1: Build --------
FROM node:18-slim AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# -------- Stage 2: Production --------
FROM node:18-slim

WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

COPY --from=builder /app ./

EXPOSE 1337
CMD ["npm", "run", "start"]

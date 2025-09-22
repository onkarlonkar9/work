# syntax=docker/dockerfile:1

# Stage 1: Build
FROM node:18-slim AS builder

WORKDIR /app

# Copy package files first (for caching)
COPY package*.json ./
COPY yarn.lock ./

# Install dependencies
RUN npm install

# Copy rest of source (including tsconfig, src folder, etc.)
COPY . .

# Optional: if you want to skip typescript type checking
# ENV SKIP_TYPE_CHECK=true

# Build the project
RUN npm run build

# Stage 2: Production image
FROM node:18-slim AS production

WORKDIR /app

# Copy only needed files: build outputs, package.json, etc.
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/build ./build         # adjust if Strapi outputs to build/dist etc
# Copy other needed files (public, config, etc) if relevant
COPY --from=builder /app/public ./public
COPY --from=builder /app/config ./config

EXPOSE 1337

CMD ["npm", "start"]

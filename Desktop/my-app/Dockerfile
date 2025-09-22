# Stage 1: Builder
FROM node:18-slim AS builder

WORKDIR /app

# Copy package files first (for caching)
COPY work/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the source code
COPY work/. .

# Build Strapi
RUN npm run build

# Stage 2: Production image
FROM node:18-slim AS production

WORKDIR /app

# Copy only needed files from builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/build ./build   # adjust if Strapi outputs to another folder
COPY --from=builder /app/public ./public
COPY --from=builder /app/config ./config

EXPOSE 1337

CMD ["npm", "start"]

# Stage 1 - Build
FROM node:18 AS builder
WORKDIR /app
COPY app/ .
RUN npm init -y

# Stage 2 - Production (SMALL IMAGE)
FROM node:18-alpine

WORKDIR /app
COPY --from=builder /app .

# ❗ Create non-root user (VERY IMPORTANT FOR TASK)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000
CMD ["node", "app.js"]
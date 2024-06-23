# syntax=docker/dockerfile:1.7-labs
FROM node:22.3.0-bookworm-slim AS builder

WORKDIR /app
COPY package.json package-lock.json ./
COPY --parents packages/*/package.json ./

RUN --mount=type=secret,id=gcloud-adc \
  GOOGLE_APPLICATION_CREDENTIALS=/run/secrets/gcloud-adc \
  npm ci

COPY --parents packages/* ./
RUN npm run gcp-build && npm prune --omit=dev

# FROM node:22.3.0-bookworm-slim

# WORKDIR /app
# COPY package.json package-lock.json ./
# COPY --from=builder /app/node_modules/ ./node_modules/

# WORKDIR /app/packages/discord-bot
# COPY packages/discord-bot/package.json ./
# COPY --from=builder /app/packages/discord-bot/dist/ ./

# WORKDIR /app
# CMD ["node", "packages/discord-bot/index.js"]
# EXPOSE 3000

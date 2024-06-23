FROM node:22.3.0-bookworm-slim AS builder

WORKDIR /app
COPY package.json package-lock.json ./

WORKDIR /app/packages/newt-storage
COPY packages/newt-storage/package.json ./

WORKDIR /app/packages/youtube-fetcher
COPY packages/youtube-fetcher/package.json ./

WORKDIR /app
RUN npm ci

COPY tsconfig.json ./
COPY packages/newt-storage/ packages/newt-storage/
COPY packages/youtube-fetcher/ packages/youtube-fetcher/
RUN npm run gcp-build && npm prune --omit=dev

FROM node:22.3.0-bookworm-slim

WORKDIR /app
COPY package.json package-lock.json ./
COPY --from=builder /app/node_modules/ ./node_modules/

WORKDIR /app/packages/discord-bot
COPY packages/discord-bot/package.json ./
COPY --from=builder /app/packages/discord-bot/dist/ ./

WORKDIR /app
CMD ["node", "packages/discord-bot/index.js"]
EXPOSE 3000

# syntax=docker/dockerfile:1.7-labs
FROM node:22.3.0-bookworm-slim AS builder

WORKDIR /app
COPY package.json package-lock.json ./
COPY --parents packages/*/package.json ./

RUN npm ci

COPY --parents packages/* ./
RUN npm run gcp-build && npm prune --omit=dev

FROM node:22.3.0-bookworm-slim

WORKDIR /app
COPY package.json package-lock.json ./
COPY --from=builder /app/node_modules/ ./node_modules/
COPY --parents --exclude=*.ts packages/* ./

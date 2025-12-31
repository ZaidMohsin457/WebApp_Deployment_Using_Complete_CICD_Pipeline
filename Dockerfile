# Dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production || true
COPY . .
# simple server using serve or express
RUN npm install -g serve
EXPOSE 3000
CMD ["npm","run","serve"]

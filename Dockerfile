FROM node:24-bullseye-slim

WORKDIR /app

# Install system dependencies required for mysqlclient
RUN apt-get update && apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*
    
COPY package*.json tsconfig.json ./
RUN npm ci

COPY src ./src

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]

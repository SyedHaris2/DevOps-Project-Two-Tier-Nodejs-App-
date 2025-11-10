FROM node:24-bullseye-slim

WORKDIR /app

# Install system dependencies required for MySQL client
RUN apt-get update && apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Copy package.json and tsconfig.json to leverage Docker cache
COPY package*.json tsconfig.json ./
RUN npm ci

# Copy source code
COPY src ./src

# Build the project (if using TypeScript)
RUN npm run build

# Expose port (same as in docker-compose)
EXPOSE 3000

# Command to run the Node.js app
CMD ["npm", "start"]

# Use Node.js Alpine image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies (including devDependencies for http-server)
RUN npm install

# Copy app source
COPY . .

# Build the app if needed
RUN npm run build

# Install http-server globally
RUN npm install -g http-server serve

# Expose the port your app will run on
EXPOSE 7002

# Run the app

CMD ["npm","run","serve"]

# Use official Node.js base image
FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy app files
COPY . .

# Expose app port (change if yours is different)
EXPOSE 3000

# Start the app
CMD ["npm", "Start"]

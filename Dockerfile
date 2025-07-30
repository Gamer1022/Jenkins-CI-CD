# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies (including dev dependencies)
RUN npm install

# Copy the rest of your app
COPY . .

# Install nodemon globally (optional but helpful)
RUN npm install -g nodemon

# Expose your app's port (adjust if needed)
EXPOSE 3000

# Default command to run your app
CMD ["npm", "start"]

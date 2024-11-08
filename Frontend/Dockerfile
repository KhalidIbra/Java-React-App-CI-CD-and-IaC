# Uses Node.js as a base image
FROM node:23

# Sets the working directory inside the container
WORKDIR /app

# Copies package.json and package-lock.json (for npm)
COPY frontend/package.json frontend/package-lock.json ./

# Installs the dependencies specified in package.json
RUN npm install

# Copies the rest of the frontend application code
COPY frontend/ ./

# Builds the React app for production
RUN npm run build

# Exposes the port the app will run on
EXPOSE 80

# Serves the app using a simple static server
CMD ["npx", "serve", "-s", "build"]

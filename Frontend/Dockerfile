FROM node:23

WORKDIR /app

COPY Frontend/package.json Frontend/package-lock.json ./

RUN npm install

COPY Frontend/ ./

RUN npm run build

EXPOSE 80

CMD ["npx", "serve", "-s", "build"]

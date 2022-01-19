FROM node:16.13-alpine3.15

WORKDIR /app

COPY package.json .
RUN npm install

COPY index.js .

USER node
ENTRYPOINT [ "npm" ]
CMD [ "run", "production" ]
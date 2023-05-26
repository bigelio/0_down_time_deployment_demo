

FROM node:16.15.1-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
RUN sudo chmod -R 777 /home/node
WORKDIR /home/node/app

COPY ./api-app/package*.json ./

USER node

RUN npm install

COPY --chown=node:node . .

EXPOSE 8080

CMD [ "node", "app.js" ]


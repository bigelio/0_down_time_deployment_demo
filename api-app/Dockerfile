
# Pull base image nodejs image.
FROM node:18.13.0-alpine
USER root
RUN mkdir /tmp/npm &&  chmod 2777 /tmp/npm && chown 1000:1000 /tmp/npm && npm config set cache /tmp/npm --global
RUN mkdir -p /home/node/app/node_modules &&  chmod 2777 /home/node/app && chown 1000:1000 /home/node/app



# Install bash. 
RUN apk update && apk add bash && apk add curl

WORKDIR /home/node/app

COPY package*.json ./

USER node

RUN npm install

COPY --chown=node:node . .

EXPOSE 8080

CMD [ "node", "app.js" ]

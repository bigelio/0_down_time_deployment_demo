
FROM node:16.15.1-alpine

USER root
RUN mkdir /tmp/npm &&  chmod 2777 /tmp/npm && chown 1000:1000 /tmp/npm && npm config set cache /tmp/npm --global

RUN mkdir  /usr/src
WORKDIR /usr/src

COPY ./web-app/package*.json ./

RUN npm install

COPY  . .

EXPOSE 3000

CMD [ "npm","run", "start" ]

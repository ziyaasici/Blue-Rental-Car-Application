FROM node:14

WORKDIR /app

COPY ./client/package*.json ./

RUN yarn install

COPY ./client/ .

EXPOSE 3000

CMD ["yarn", "run", "start"]
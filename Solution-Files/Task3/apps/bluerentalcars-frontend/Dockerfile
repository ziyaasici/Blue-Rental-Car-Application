FROM node:14

WORKDIR /app

COPY ./react/client/package*.json ./

RUN yarn install

COPY ./react/client/ .

EXPOSE 3000

CMD ["yarn", "run", "start"]
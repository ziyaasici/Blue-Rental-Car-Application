# FROM node:14

# WORKDIR /app

# COPY ./package*.json ./

# RUN yarn install

# COPY ./ .

# EXPOSE 3000

# CMD ["yarn", "run", "start"]


FROM node:16.18
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm","start"]
FROM node:18-alpine as build

WORKDIR /app

COPY . /app

RUN npm install

RUN npm install npm@latest -g

FROM buildkite/puppeteer:latest

WORKDIR /app

COPY --from=build /app /app

RUN npm install

CMD ["npm", "start"]

EXPOSE 8080

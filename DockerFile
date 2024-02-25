FROM node:16.0.0-alpine as builder
WORKDIR /node-js-sample
COPY ./package.json .
COPY ./package-lock.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
# estágio de compilação
FROM node:10.13-alpine as build-stage
WORKDIR /dist/src/app
COPY ./frontend/package*.json ./
RUN npm cache clean --force
RUN npm install
COPY ./frontend .
RUN npm run build

# estágio de produção
FROM nginx:stable-alpine as production-stage
RUN mkdir /app
COPY --from=build-stage /dist/src/app/dist/frontend /usr/share/nginx/html
COPY /ngnix/default.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
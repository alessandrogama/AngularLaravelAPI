# estágio de compilação
FROM node:8.12-alpine as build-stage
WORKDIR /app
COPY ./coreui/package*.json ./
RUN npm install
COPY ./coreui .
RUN npm run build

# estágio de produção
FROM nginx:stable-alpine as production-stage
RUN mkdir /app
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
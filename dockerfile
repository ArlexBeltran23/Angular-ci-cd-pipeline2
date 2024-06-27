FROM node:latest AS build

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build --prod

# Etapa de producción
FROM nginx:latest

COPY --from=build /app/dist/auth-app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

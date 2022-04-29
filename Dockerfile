#Build
FROM node:16.13.2-alpine as build
WORKDIR /usr/app
COPY package.json .
COPY yarn.lock .
RUN yarn install
COPY . .
RUN yarn build

#RUN
FROM nginx:1.12-alpine
COPY --from=build /usr/app/build/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

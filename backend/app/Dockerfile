FROM node:19-alpine as builder
ENV PORT=80
WORKDIR /app
COPY . . 
RUN yarn install 
RUN yarn run build
EXPOSE 80
CMD ["yarn", "start:prod"]
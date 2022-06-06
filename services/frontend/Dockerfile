FROM node:14-slim as ui-builder
WORKDIR /home/ui
COPY . .

# install and build
RUN npm install
RUN npm run build

# nginx deploy
FROM nginx
COPY default.conf /etc/nginx/conf.d/default.conf
COPY fullchain.pem /etc/ssl/certs/fullchain.pem
COPY privkey.pem /etc/ssl/private/privkey.pem

COPY --from=ui-builder /home/ui/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
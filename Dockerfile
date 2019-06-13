# From base image tagged a builder ( i.e. naming your stage)
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- has all our stuff to go to next stage or phase

# A new FROM signals a new phase or block
FROM nginx
EXPOSE 80
# NGINX container documentation specifies static folder is /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html

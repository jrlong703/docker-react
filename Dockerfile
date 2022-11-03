# STEP 1 -- build phase
FROM node:16-alpine as builder

WORKDIR /usr/app
COPY package.json .
RUN npm install
COPY .  .

RUN npm run build

# STEP 2 -- run phase
FROM nginx

# all the server needs is the build directory
COPY --from=builder /usr/app/build /usr/share/nginx/html

# nginx will start up on its own when we start the container

FROM alpine as builder

COPY ./website /home/website

WORKDIR /home/website
RUN apk add zola --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ && \ 
    zola build

FROM nginx:alpine

COPY --from=builder /home/website/public /usr/share/nginx/html
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

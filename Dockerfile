#FROM nginx:1.17.7-alpine
FROM openresty/openresty:alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY hide_server_tokens.conf /etc/nginx/conf.d/hide_server_tokens.conf
COPY app.conf /etc/nginx/conf.d/app.conf

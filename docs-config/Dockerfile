
FROM squidfunk/mkdocs-material as builder

MAINTAINER github.com/gabrielpsilva

WORKDIR /opt
ADD docs-config/mkdocs.yml ./
ADD docs ./docs
RUN mkdocs build


FROM nginx:alpine

WORKDIR /opt

RUN rm /etc/nginx/conf.d/*
COPY --from=builder /opt/site /site
ADD docs-config/nginx-mkdocs.conf /etc/nginx/conf.d/
RUN sed -i "s|#gzip  on;|gzip  on; etag  off; server_tokens off; gzip_types *;|" /etc/nginx/nginx.conf

FROM docker.io/nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY plugins /usr/share/nginx/html/plugins
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
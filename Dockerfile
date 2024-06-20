FROM antora/antora:3.0.1 as build-site

COPY . /project
RUN cd /project && antora antora-playbook.yml


FROM nginxinc/nginx-unprivileged:1.21-alpine

COPY --from=build-site --chown=nginx:nginx /project/build/site /usr/share/nginx/html
WORKDIR /usr/share/nginx

CMD ["nginx", "-g", "daemon off;"]

# Base image:
FROM nginx:alpine
# Install dependencies
#RUN apt-get update -qq && apt-get -y install apache2-utils

# establish where Nginx should look for files
ENV RAILS_ROOT /usr/src/app

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# create log directory
RUN mkdir log

# Copy Nginx config template
COPY /docker/nginx/menu.conf /etc/nginx/conf.d/menu.conf
COPY /docker/nginx/app.conf /etc/nginx/conf.d/app.conf

# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place

EXPOSE 80

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
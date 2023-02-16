# set the base image to Nginx
FROM nginx

# install mysql client for testing connection between nginx pod and mysql pod
RUN apt-get update && apt-get install -y default-mysql-client

# replace the default page for nginx
COPY index.html /usr/share/nginx/html/

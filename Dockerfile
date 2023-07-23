#Install the container's OS.
FROM --platform=linux/amd64 ubuntu:latest as PORTFOLIOSETUP

# Install Hugo.
RUN apt-get update

# Copy the contents of the current working directory to the hugo-site
# directory. The directory will be created if it doesn't exist.
COPY . /my-portfolio

# Install NGINX and deactivate NGINX's default index.html file.
# Move the static site files to NGINX's html directory.
# This directory is where the static site files will be served from by NGINX.
FROM --platform=linux/amd64 nginx
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=PORTFOLIOSETUP /my-portfolio/ /usr/share/nginx/html/

# The container will listen on port 80 using the TCP protocol.
EXPOSE 80

FROM phusion/passenger-full:0.9.8

# Setup Nginx
RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf
RUN rm -f /etc/service/nginx/down

# Load app
RUN mkdir /home/app/webapp
WORKDIR /home/app/webapp
ADD . /home/app/webapp

# Prep app
RUN bundle install --deployment

CMD ["/sbin/my_init"]
EXPOSE 80

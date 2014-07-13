FROM ubuntu:14.04
 
RUN apt-get update -q

#Utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl build-essential

#Utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# install RVM, Ruby, and Bundler
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN /bin/bash -l -c "gem install dashing"


WORKDIR /tmp 
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN /bin/bash -l -c "bundle install"
RUN /bin/bash -l -c "rvm use 2.1 --default"

ADD ./ /dashboard

WORKDIR /dashboard
CMD ["/bin/bash", "-l", "-c", "dashing start"]

EXPOSE 3030
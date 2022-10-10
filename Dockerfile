# syntax=docker/dockerfile:1
FROM ruby:2.7.3
RUN apt-get update -qq && apt-get install -y postgresql-client
SHELL ["/bin/bash", "--login", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN nvm install 16.15.1
RUN nvm cache clear
RUN npm install -g yarn
RUN gem update --system && \
    gem install bundler
WORKDIR /trainingtrack
COPY Gemfile /trainingtrack/Gemfile
COPY Gemfile.lock /trainingtrack/Gemfile.lock
RUN bundle install
RUN yarn install
RUN bundle

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]

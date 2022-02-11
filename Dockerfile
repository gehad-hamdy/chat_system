FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y nodejs

WORKDIR /chat_system
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE $APPLICATION_PORT
EXPOSE $DEBUGGING_PORT

## Add the wait script to mysql image
COPY wait_mysql_progress.sh /wait_mysql_progress.sh
RUN chmod +x /wait_mysql_progress.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
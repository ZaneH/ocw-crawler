FROM ruby:2.5.0-stretch

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
RUN apt update && apt install -q -y xvfb firefox-esr lsof

WORKDIR /tmp
RUN \
    wget https://github.com/mozilla/geckodriver/releases/download/v0.23.0/geckodriver-v0.23.0-linux64.tar.gz && \
    tar -xvzf geckodriver-v0.23.0-linux64.tar.gz -C /usr/local/bin && \
    rm -f geckodriver-v0.23.0-linux64.tar.gz

RUN mkdir -p /app

WORKDIR /app
ADD Gemfile /app
RUN bundle install

COPY . .

CMD ["ruby", "crawler.rb"]
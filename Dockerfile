FROM --platform=amd64 ruby:3.1.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && curl -fsSL https://deb.nodesource.com/setup_14.x | bash \
  && apt-get install -y nodejs cron \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /renarena2

RUN npm install --global yarn
RUN yarn install --network-timeout 600000

WORKDIR /renarena2
COPY Gemfile /renarena2/Gemfile

COPY Gemfile.lock /renarena2/Gemfile.lock

RUN bundle install

COPY . /renarena2

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
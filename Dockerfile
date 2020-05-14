FROM ruby:2.5.3

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -qq -y build-essential graphviz nodejs wait-for-it yarn \
    libpq-dev \
    postgresql-client  \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock package.json yarn.lock ./

RUN yarn install
RUN bundle install

COPY . .

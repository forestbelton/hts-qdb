FROM fpco/stack-build:lts-6.14

RUN apt-get -y install nodejs

COPY . /app

WORKDIR /app/client
ENV NPM_CONFIG_LOGLEVEL warn
RUN npm install
RUN npm run build

WORKDIR /app
RUN stack build

CMD ["stack", "exec", "qdb-exe"]

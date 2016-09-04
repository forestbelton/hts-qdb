QDB
===
Yet Another QDB Service

Installation
------------

1. Make sure you have [PostgreSQL](https://www.postgresql.org/) 9.5 or later installed and running.
2. Install [Node.js](https://nodejs.org/en/).
2. Install [Stack](https://docs.haskellstack.org/en/stable/README/).
3. In the project directory, run the following:

```bash
# Build the frontend
$ cd client
$ npm install
$ npm run build
$ cd ..
# Set up the database (only run once)
$ ./scripts/init-db.sh
# Build the application
$ stack build
$ stack exec hts-qdb-exe
```

You should now have a QDB service running on the default port. Enjoy!

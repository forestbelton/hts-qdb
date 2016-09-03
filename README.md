QDB
===
Yet Another QDB Service

Installation
------------

1. Make sure you have [PostgreSQL](https://www.postgresql.org/) 9.5 or later installed and running.
1. Install [Stack](https://docs.haskellstack.org/en/stable/README/).
2. In the project directory, run the following:

```
$ ./scripts/init-db.sh # only run once
$ stack build
$ stack exec hts-qdb-exe
```

You should now have a QDB service running on the default port. Enjoy!

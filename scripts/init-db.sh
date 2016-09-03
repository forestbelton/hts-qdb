#!/bin/sh

USER=ujboldoppi4v4ge7kyfc
PASS=p1pFM5Cruo9GGFhu3EZt

psql postgres <<EOF
DROP DATABASE IF EXISTS qdb;
DROP USER IF EXISTS $USER;

CREATE USER $USER
    WITH PASSWORD '$PASS';

CREATE DATABASE qdb WITH OWNER $USER;
EOF

export PGPASSWORD="$PASS"
psql -U $USER qdb <<EOF
CREATE TABLE quotes(
    id BIGSERIAL PRIMARY KEY,
    createdDate TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    content TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS quotes_createdDate_idx ON quotes (createdDate);

CREATE TABLE votes (
    id BIGSERIAL PRIMARY KEY,
    createdDate TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    quoteId BIGINT NOT NULL REFERENCES quotes,
    ipAddress TEXT NOT NULL,
    type TEXT NOT NULL,
    UNIQUE (quoteId, ipAddress)
);

CREATE INDEX IF NOT EXISTS votes_createdDate_idx ON votes (createdDate);
CREATE INDEX IF NOT EXISTS votes_quoteId_idx ON votes (quoteId);
EOF

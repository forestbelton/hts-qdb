#!/bin/bash

# Go to script directory
cd "$(dirname "$0")"
cd ..

# Build the frontend
cd client
npm install
npm run build
cd ..

# Set up the database (only run once)
./scripts/init-db.sh

# Build the application
stack build
stack exec hts-qdb-exe

#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    create role admin with login password 'password';
    create database chirpstack with owner admin;
EOSQL

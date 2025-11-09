--liquibase formatted sql


--changeset pas:create-table-archives
CREATE TABLE archives (
  id BIGINT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  symbol VARCHAR(32) NOT NULL,
  filename VARCHAR(64) NOT NULL,
  year_month_day DATE NOT NULL,
  url VARCHAR(128) NOT NULL,
  sha256_hex VARCHAR(64) DEFAULT NULL,
  ingested BOOLEAN NOT NULL DEFAULT FALSE, -- into trades table
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (symbol, year_month_day)
);


--changeset pas:create-table-trades
CREATE TABLE trades (
  archive_id BIGINT REFERENCES archives (id),
  id BIGINT PRIMARY KEY NOT NULL,
  price DOUBLE PRECISION NOT NULL,
  qty DOUBLE PRECISION NOT NULL,
  quoteQty DOUBLE PRECISION NOT NULL,
  time BIGINT NOT NULL,
  isBuyerMaker BOOLEAN NOT NULL,
  isBestMatch BOOLEAN NOT NULL
);


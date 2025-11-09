FROM ubuntu:22.04 AS build

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      pkg-config \
      libcurl4-openssl-dev \
      libssl-dev \
      libpqxx-dev \
      libzip-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY src ./src

RUN mkdir -p bin && \
    g++ -std=c++17 ./src/*.cpp -o bin/app -lcurl -lcrypto -lpqxx -lzip


FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libcurl4 \
      libssl3 \
      libpqxx-dev \
      libzip4 \
      ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=build /app/bin/app /app/binahistory

RUN chmod +x /app/binahistory

ENTRYPOINT ["/app/binahistory"]

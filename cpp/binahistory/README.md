- You need `docker` and `docker compose` to run this project
- It's just a script that downloads historical trades data from Binance and populates it into a database
- To run execute `docker compose build` and `docker compose up -d`
- Check data in database via `psql -h 127.0.0.1 -p 5432 -d trade -U app`. Password is `postgres`


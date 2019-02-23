# Rails Zen

This is a skeleton app for writing APIs.

This skeleton allows you to achieve zen

## Features

- Uses Grape API
- Provides Swagger UI for viewing your API
- Has Papertrail
- IDs default to ULIDs
- Comes with Redis
- Comes with Sidekiq
- Comes with a nice docker compose that sets up a dev environment that you can use immediately
- Devise for swagger and sidekiq dashboards (and everything else you want)
- Pre-prepared browser test suite
- Constantly updates dependencies

## Getting Started

```
docker-compose up -d   # Start stack
```

```
docker-compose down -v # Shutdown stack
```

```
docker-compose exec rails rspec # Run tests
```

View your API at http://localhost:3000/swagger

Comes with PGAdmin at http://localhost:5050.

```
user: admin@example.com
pass: admin
```

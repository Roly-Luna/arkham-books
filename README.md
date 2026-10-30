# Arkham Books - Data Tier

Data layer for the Arkham Books bookstore and reader community.

## Architecture

- PostgreSQL stores users, products, publishers, authors, categories and orders.
- MongoDB stores posts, comments and reactions.
- FastAPI coordinates requests and validates PostgreSQL user references before writing social content.

## Structure

- data-tier/schema.sql: relational schema for a fresh database
- data-tier/seeds.sql: demo records for an empty database only
- data-tier/queries.sql: read-only checks and reporting queries
- data-tier/migrations/: incremental changes for an existing database
- data-tier/postgresql/: PostgreSQL deployment notes
- data-tier/mongodb/: Docker Compose, initialization and persistence

## Important

Do not run old schema scripts that drop or recreate a database on VM1. Verify the live database name, back it up and apply only reviewed migrations. Existing deployment notes use arkham_db, while an older script uses ArkhamBooks.

MongoDB must listen on VM1's private address and accept connections only from VM2 through the Azure network security rules. Never commit credentials, .env files or database dumps.

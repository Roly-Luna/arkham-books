# PostgreSQL deployment

For the current PC2/TB1 deployment, verify the actual database name before changing anything. Some older scripts refer to ArkhamBooks while operational documents refer to arkham_db.

## Existing database

Create a backup before applying the PC3 migration:

```bash
pg_dump -h 172.16.0.4 -U arkham_app -d arkham_db -Fc -f arkham_books_before_pc3.dump
psql -h 172.16.0.4 -U arkham_app -d arkham_db -v ON_ERROR_STOP=1 -f data-tier/migrations/001_pc3_user_profile.sql
```

Run the migration only after confirming the database name and reviewing the backup. It adds public profile fields and indexes without dropping tables or records.

## New database

Create the database separately, then run data-tier/schema.sql. Load data-tier/seeds.sql only into a fresh empty database. Never run demo seeds against the group's live database.

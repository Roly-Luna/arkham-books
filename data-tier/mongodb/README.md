# MongoDB - Community Data

MongoDB stores social content. PostgreSQL remains the source of truth for users, products, inventory and orders.

## Collections

- posts: text posts, reviews and recommendations
- comments: comments linked to a post and a PostgreSQL user ID
- reactions: one reaction per user and post

The author_id and user_id fields reference usuario.id_usuario in PostgreSQL. Account credentials are never copied to MongoDB.

## Deploy on VM1

1. Copy this folder to VM1 or clone the repository
2. Copy .env.example to .env
3. Replace all sample passwords with strong unique values
4. Set MONGO_BIND_IP to VM1 private IP
5. Allow TCP 27017 in the Azure NSG only from VM2 private IP

```bash
cd data-tier/mongodb
cp .env.example .env
chmod 600 .env
nano .env
docker compose up -d
docker compose ps
docker compose logs --tail=100 mongodb
```

Do not bind MongoDB to 0.0.0.0 or expose port 27017 to the public internet.

## FastAPI connection

Set MONGODB_URI and MONGODB_DB in the application .env file. Use VM1 private IP, URL-encode special characters in the password and set authSource to arkham_social.

## Persistence

The named Docker volume mongo_data stores database files outside the container. Recreating the container does not remove the volume.

Never commit .env files, credentials or database dumps.

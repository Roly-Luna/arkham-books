const databaseName = process.env.MONGO_DB || db.getName();
const appUser = process.env.MONGO_APP_USER;
const appPassword = process.env.MONGO_APP_PASSWORD;

if (!appUser || !appPassword) {
    throw new Error("MONGO_APP_USER and MONGO_APP_PASSWORD are required");
}

const appDatabase = db.getSiblingDB(databaseName);

if (!appDatabase.getUser(appUser)) {
    appDatabase.createUser({
        user: appUser,
        pwd: appPassword,
        roles: [{ role: "readWrite", db: databaseName }]
    });
}

appDatabase.posts.createIndex({ created_at: -1 });
appDatabase.posts.createIndex({ author_id: 1, created_at: -1 });
appDatabase.comments.createIndex({ post_id: 1, created_at: 1 });
appDatabase.reactions.createIndex({ post_id: 1, user_id: 1 }, { unique: true });

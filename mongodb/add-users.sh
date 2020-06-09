mongo \
    --port 27017 \
    --authenticationDatabase 'admin' \
    --username mongoroot \
    --password mongoroot \
    <<JS
// Switch to admin db
use "admin"

// Add Laravel user
db.createUser(
    {
        user: "laravel",
        pwd: "laravel",
        roles: [
            { role: "readWrite", db: "laravel" }
        ]
    }
)
JS

mongo --port 27017 <<JS
// Switch to admin db
use admin

// Login
db.auth("docker-admin", "docker-admin")

// Add Laravel user
db.createUser(
    {
        user: "laravel",
        pwd: "laravel",
        roles: [
            { role: "readWrite", db: "laravel" },
            { role: "read", db: "laravel-testing" }
        ]
    }
)
// Add Laravel test user
db.createUser(
    {
        user: "laravel-testing",
        pwd: "laravel",
        roles: [
            { role: "read", db: "laravel" },
            { role: "readWrite", db: "laravel-testing" }
        ]
    }
)

// Add Compass user
db.createUser(
    {
        user: "compass",
        pwd: "monitor",
        roles: [
            { role: "read", db: "laravel" },
            { role: "readWrite", db: "laravel-testing" }
        ]
    }
)
JS

package main

import (
    "log"
    "net/http"
    "quiz_app_go/config"
    "quiz_app_go/controllers"
    "quiz_app_go/routes"
    "github.com/gorilla/mux"
)

func main() {
    // Connect to the database
    config.ConnectDB()

    // Initialize the user collection in the controller
    controllers.SetUserCollection(config.DB.Collection("users"))

    // Initialize the router
    r := mux.NewRouter()

    // Set up the routes
    routes.UserRoutes(r)

    // Start the server
    log.Println("Server is running on port 8080")
    log.Fatal(http.ListenAndServe(":8080", r))
}

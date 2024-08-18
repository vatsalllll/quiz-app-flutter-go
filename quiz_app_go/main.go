package main

import (
    "log"
    "net/http"

    "quiz_app_go/config"
    "quiz_app_go/controllers"
    "quiz_app_go/routes"
    "github.com/gorilla/mux"
    "github.com/rs/cors"
)

func main() {
    // Connect to the database
    config.ConnectDB()

    // Initialize the user collection in the controller
    controllers.SetUserCollection(config.DB.Collection("users"))

    // Initialize the router
    r := mux.NewRouter()

    // Set up the user routes
    routes.UserRoutes(r)

    // Configure CORS
    c := cors.New(cors.Options{
        AllowedOrigins:   []string{"*"}, // Allow all origins, adjust as necessary
        AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
        AllowedHeaders:   []string{"Content-Type", "Authorization"},
        AllowCredentials: true,
    })

    // Wrap the router with the CORS middleware
    handler := c.Handler(r)

    // Start the server
    log.Println("Server is running on port 8080")
    log.Fatal(http.ListenAndServe(":8080", handler))
}
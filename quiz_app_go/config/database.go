package config

import (
    "context"
    "log"
    "time"
    "go.mongodb.org/mongo-driver/mongo"
    "go.mongodb.org/mongo-driver/mongo/options"
)

var DB *mongo.Database

func ConnectDB() {
    // Replace with your MongoDB connection string
    clientOptions := options.Client().ApplyURI("mongodb+srv://vatsalsgpt:zJX8uifYyYsfv9Hr@cluster0.bottd.mongodb.net/?retryWrites=true&w=majority")

    client, err := mongo.NewClient(clientOptions)
    if err != nil {
        log.Fatal(err)
    }

    ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()

    err = client.Connect(ctx)
    if err != nil {
        log.Fatal(err)
    }

    DB = client.Database("quiz_app")
    log.Println("Connected to MongoDB!")
}

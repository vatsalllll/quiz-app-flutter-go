package controllers

import (
    "context"
    "encoding/json"
    "net/http"
    "quiz_app_go/models"
    "time"
    "golang.org/x/crypto/bcrypt"
    "go.mongodb.org/mongo-driver/bson"
    "go.mongodb.org/mongo-driver/bson/primitive"
    "go.mongodb.org/mongo-driver/mongo"
)

// Declare the userCollection variable
var userCollection *mongo.Collection

// Function to set userCollection after DB connection is established
func SetUserCollection(collection *mongo.Collection) {
    userCollection = collection
}

func hashPassword(password string) (string, error) {
    bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
    return string(bytes), err
}

func checkPasswordHash(password, hash string) bool {
    err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
    return err == nil
}

func RegisterUser(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    var user models.User
    _ = json.NewDecoder(r.Body).Decode(&user)
    user.ID = primitive.NewObjectID()

    hashedPassword, err := hashPassword(user.Password)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    user.Password = hashedPassword

    ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
    defer cancel()

    _, err = userCollection.InsertOne(ctx, user)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    json.NewEncoder(w).Encode(user)
}

func LoginUser(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    var user models.User
    _ = json.NewDecoder(r.Body).Decode(&user)

    var foundUser models.User
    ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
    defer cancel()

    err := userCollection.FindOne(ctx, bson.M{"email": user.Email}).Decode(&foundUser)
    if err != nil {
        http.Error(w, "User not found", http.StatusNotFound)
        return
    }

    if !checkPasswordHash(user.Password, foundUser.Password) {
        http.Error(w, "Invalid credentials", http.StatusUnauthorized)
        return
    }

    json.NewEncoder(w).Encode(foundUser)
}

func GetUser(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    params := r.URL.Query().Get("id")
    id, _ := primitive.ObjectIDFromHex(params)

    var user models.User
    ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
    defer cancel()

    err := userCollection.FindOne(ctx, bson.M{"_id": id}).Decode(&user)
    if err != nil {
        http.Error(w, err.Error(), http.StatusNotFound)
        return
    }
    json.NewEncoder(w).Encode(user)
}

func UpdateUser(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    params := r.URL.Query().Get("id")
    id, _ := primitive.ObjectIDFromHex(params)

    var user models.User
    _ = json.NewDecoder(r.Body).Decode(&user)

    ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
    defer cancel()

    update := bson.M{
        "$set": bson.M{
            "score": user.Score,
            "coins": user.Coins,
        },
    }

    err := userCollection.FindOneAndUpdate(ctx, bson.M{"_id": id}, update).Decode(&user)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }

    json.NewEncoder(w).Encode(user)
}

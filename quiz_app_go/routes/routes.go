package routes

import (
    "quiz_app_go/controllers"
    "github.com/gorilla/mux"
)

func UserRoutes(router *mux.Router) {
    router.HandleFunc("/register", controllers.RegisterUser).Methods("POST")
    router.HandleFunc("/login", controllers.LoginUser).Methods("POST")
    router.HandleFunc("/user", controllers.GetUser).Methods("GET")
    router.HandleFunc("/user", controllers.UpdateUser).Methods("PUT")
}

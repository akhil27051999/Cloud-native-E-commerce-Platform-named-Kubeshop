package main

import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/pay", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Payment processed")
    })

    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Payments Service Running")
    })

    http.ListenAndServe(":8081", nil)
}


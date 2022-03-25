package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	// Declare a route at / and a handler that prints the environment variable
	http.HandleFunc(
		"/", func(w http.ResponseWriter, r *http.Request) {
			fmt.Fprintf(w, "Hello, %s", os.Getenv("TEST_VARIABLE"))
		},
	)

	// Start the server on port 8080
	http.ListenAndServe(":8080", nil)
}

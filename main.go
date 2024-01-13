package main

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.GET("/", func(c *gin.Context) {
		fmt.Println("aaa")
		c.String(http.StatusOK, "hello world")
	})

	err := router.Run("0.0.0.0:8080")
	if err != nil {
		fmt.Print(err.Error())
	}
}

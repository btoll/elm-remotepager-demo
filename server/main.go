//go:generate goagen bootstrap -d github.com/btoll/elm-remotepager-demo/server/design

package main

import (
	"github.com/btoll/elm-remotepager-demo/server/app"
	"github.com/goadesign/goa"
	"github.com/goadesign/goa/middleware"
)

func main() {
	// Create service
	service := goa.New("elm-remotepager-demo")

	// Mount middleware
	service.Use(middleware.RequestID())
	service.Use(middleware.LogRequest(true))
	service.Use(middleware.ErrorHandler(service, true))
	service.Use(middleware.Recover())

	// Mount "Hacker" controller
	c := NewHackerController(service)
	app.MountHackerController(service, c)

	// Start service
	if err := service.ListenAndServe(":8080"); err != nil {
		service.LogError("startup", "err", err)
	}

}

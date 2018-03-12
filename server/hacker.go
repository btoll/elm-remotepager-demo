package main

import (
	"strconv"

	"github.com/btoll/elm-remotepager-demo/server/app"
	"github.com/btoll/elm-remotepager-demo/server/sql"
	"github.com/goadesign/goa"
)

// HackerController implements the Hacker resource.
type HackerController struct {
	*goa.Controller
}

// NewHackerController creates a Hacker controller.
func NewHackerController(service *goa.Service) *HackerController {
	return &HackerController{Controller: service.NewController("HackerController")}
}

// Create runs the create action.
func (c *HackerController) Create(ctx *app.CreateHackerContext) error {
	// HackerController_Create: start_implement

	res, err := sql.Create(sql.NewHacker(ctx.Payload))
	if err != nil {
		return err
	}
	return ctx.OK(res.(*app.HackerMedia))

	// HackerController_Create: end_implement
}

// Delete runs the delete action.
func (c *HackerController) Delete(ctx *app.DeleteHackerContext) error {
	// HackerController_Delete: start_implement

	err := sql.Delete(sql.NewHacker(ctx.ID))
	if err != nil {
		return err
	}
	return ctx.OKTiny(&app.HackerMediaTiny{ctx.ID})

	// HackerController_Delete: end_implement
}

// List runs the list action.
func (c *HackerController) List(ctx *app.ListHackerContext) error {
	// HackerController_List: start_implement

	collection, err := sql.List(sql.NewHacker(nil))
	if err != nil {
		return err
	}
	return ctx.OK(collection.(app.HackerMediaCollection))

	// HackerController_List: end_implement
}

// Page runs the page action.
func (c *HackerController) Page(ctx *app.PageHackerContext) error {
	// HackerController_Page: start_implement

	collection, err := sql.Page(sql.NewHacker(ctx.Page))
	if err != nil {
		return err
	}
	return ctx.OKPaging(collection.(*app.HackerMediaPaging))

	// HackerController_Page: end_implement
}

// Show runs the show action.
func (c *HackerController) Show(ctx *app.ShowHackerContext) error {
	// HackerController_Show: start_implement

	rec, err := sql.Read(sql.NewHacker(ctx.ID))
	if err != nil {
		return err
	}
	return ctx.OK(rec.(*app.HackerMedia))

	// HackerController_Show: end_implement
}

// Update runs the update action.
func (c *HackerController) Update(ctx *app.UpdateHackerContext) error {
	// HackerController_Update: start_implement

	err := sql.Update(sql.NewHacker(ctx.Payload))
	if err != nil {
		return err
	}
	id, err := strconv.Atoi(ctx.ID)
	if err != nil {
		return err
	}
	return ctx.OKTiny(&app.HackerMediaTiny{id})

	// HackerController_Update: end_implement
}

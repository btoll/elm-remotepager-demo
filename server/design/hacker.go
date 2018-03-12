package design

import (
	. "github.com/goadesign/goa/design"
	. "github.com/goadesign/goa/design/apidsl"
)

var _ = Resource("Hacker", func() {
	BasePath("/hacker")
	Description("Describes a hacker.")

	Action("create", func() {
		Routing(POST("/"))
		Description("Create a new hacker.")
		Payload(HackerPayload)
		Response(OK, HackerMedia)
		Response(BadRequest, ErrorMedia)
	})

	Action("show", func() {
		Routing(GET("/:id"))
		Params(func() {
			Param("id", String, "Hacker ID")
		})
		Description("Get a hacker by id.")
		Response(OK, HackerMedia)
		Response(BadRequest, ErrorMedia)
	})

	Action("update", func() {
		Routing(PUT("/:id"))
		Payload(HackerPayload)
		Params(func() {
			Param("id", String, "Hacker ID")
		})
		Description("Update a hacker by id.")
		Response(OK, func() {
			Status(200)
			Media(HackerMedia, "tiny")
		})
		Response(BadRequest, ErrorMedia)
	})

	Action("delete", func() {
		Routing(DELETE("/:id"))
		Params(func() {
			Param("id", Integer, "Hacker ID")
		})
		Description("Delete a hacker by id.")
		Response(OK, func() {
			Status(200)
			Media(HackerMedia, "tiny")
		})
		Response(BadRequest, ErrorMedia)
	})

	Action("list", func() {
		Routing(GET("/list"))
		Description("Get all hackers")
		Response(OK, CollectionOf(HackerMedia))
		Response(BadRequest, ErrorMedia)
	})

	Action("page", func() {
		Routing(GET("/list/:page"))
		Params(func() {
			Param("page", Integer, "Given a page number, returns an object consisting of the slice of hackers and a pager object")
		})
		Description("Get a page of hackers")
		Response(OK, func() {
			Status(200)
			Media(HackerMedia, "paging")
		})
	})
})

var HackerPayload = Type("HackerPayload", func() {
	Description("Hacker Description.")

	Attribute("id", Integer, "ID", func() {
		Metadata("struct:tag:datastore", "id,noindex")
		Metadata("struct:tag:json", "id")
	})
	Attribute("name", String, "name", func() {
		Metadata("struct:tag:datastore", "name,noindex")
		Metadata("struct:tag:json", "name")
	})

	Required("name")
})

var HackerItem = Type("hackerItem", func() {
	Reference(HackerPayload)

	Attribute("id")
	Attribute("name")

	Required("id", "name")
})

var HackerMedia = MediaType("application/hackerapi.hackerentity", func() {
	Description("Hacker response")
	TypeName("HackerMedia")
	ContentType("application/json")
	Reference(HackerPayload)

	Attributes(func() {
		Attribute("id")
		Attribute("name")
		Attribute("hackers", ArrayOf("hackerItem"))
		Attribute("pager", Pager)

		Required("id", "name", "hackers", "pager")
	})

	View("default", func() {
		Attribute("id")
		Attribute("name")
	})

	View("paging", func() {
		Attribute("hackers")
		Attribute("pager")
	})

	View("tiny", func() {
		Description("`tiny` is the view used to create new hackers.")
		Attribute("id")
	})
})

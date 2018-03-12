package sql

import (
	mysql "database/sql"
	"fmt"
	"math"

	"github.com/btoll/elm-remotepager-demo/server/app"
)

type Hacker struct {
	Data interface{}
	Stmt map[string]string
}

func NewHacker(payload interface{}) *Hacker {
	return &Hacker{
		Data: payload,
		Stmt: map[string]string{
			"DELETE": "DELETE FROM hacker WHERE id=?",
			"INSERT": "INSERT hacker SET name=?",
			"SELECT": "SELECT %s FROM hacker %s %s",
			"UPDATE": "UPDATE hacker SET name=? WHERE id=?",
		},
	}
}

func (s *Hacker) Create(db *mysql.DB) (interface{}, error) {
	payload := s.Data.(*app.HackerPayload)
	stmt, err := db.Prepare(s.Stmt["INSERT"])
	if err != nil {
		return -1, err
	}
	res, err := stmt.Exec(payload.Name)
	if err != nil {
		return -1, err
	}
	id, err := res.LastInsertId()
	if err != nil {
		return -1, err
	}
	return &app.HackerMedia{
		ID:   int(id),
		Name: payload.Name,
	}, nil
}

func (s *Hacker) Read(db *mysql.DB) (interface{}, error) {
	row, err := db.Query(fmt.Sprintf(s.Stmt["SELECT"], "*", fmt.Sprintf("WHERE id=%d", s.Data.(int)), ""))
	if err != nil {
		return nil, err
	}
	var hacker *app.HackerMedia
	for row.Next() {
		var id int
		var name string
		err := row.Scan(&id, &name)
		if err != nil {
			return nil, err
		}
		hacker = &app.HackerMedia{
			ID:   id,
			Name: name,
		}
	}
	return hacker, nil
}

func (s *Hacker) Update(db *mysql.DB) error {
	payload := s.Data.(*app.HackerPayload)
	stmt, err := db.Prepare(s.Stmt["UPDATE"])
	if err != nil {
		return err
	}
	_, err = stmt.Exec(payload.Name, payload.ID)
	if err != nil {
		return err
	}
	return nil
}

func (s *Hacker) Delete(db *mysql.DB) error {
	stmt, err := db.Prepare(s.Stmt["DELETE"])
	if err != nil {
		return err
	}
	id := s.Data.(int)
	_, err = stmt.Exec(&id)
	return err
}

func (s *Hacker) List(db *mysql.DB) (interface{}, error) {
	rows, err := db.Query(fmt.Sprintf(s.Stmt["SELECT"], "COUNT(*)", "", ""))
	if err != nil {
		return nil, err
	}
	var count int
	for rows.Next() {
		err = rows.Scan(&count)
		if err != nil {
			return nil, err
		}
	}
	rows, err = db.Query(fmt.Sprintf(s.Stmt["SELECT"], "*", "", ""))
	if err != nil {
		return nil, err
	}
	coll := make(app.HackerMediaCollection, count)
	i := 0
	for rows.Next() {
		var id int
		var name string
		err = rows.Scan(&id, &name)
		if err != nil {
			return nil, err
		}
		coll[i] = &app.HackerMedia{
			ID:   id,
			Name: name,
		}
		i++
	}
	return coll, nil
}

func (s *Hacker) Page(db *mysql.DB) (interface{}, error) {
	// page * recordsPerPage = limit
	fmt.Println("got here")
	recordsPerPage := 10
	limit := s.Data.(int) * recordsPerPage
	rows, err := db.Query(fmt.Sprintf(s.Stmt["SELECT"], "COUNT(*)", "", ""))
	if err != nil {
		return nil, err
	}
	var totalCount int
	for rows.Next() {
		err = rows.Scan(&totalCount)
		if err != nil {
			return nil, err
		}
	}
	rows, err = db.Query(fmt.Sprintf(s.Stmt["SELECT"], "*", "", fmt.Sprintf("LIMIT %d,%d", limit, recordsPerPage)))
	if err != nil {
		return nil, err
	}
	// Only the amount of rows equal to recordsPerPage unless the last page has been requested
	// (determined by `totalCount - limit`).
	capacity := totalCount - limit
	if capacity >= recordsPerPage {
		capacity = recordsPerPage
	}
	paging := &app.HackerMediaPaging{
		Pager: &app.Pager{
			CurrentPage:    limit / recordsPerPage,
			RecordsPerPage: recordsPerPage,
			TotalCount:     totalCount,
			TotalPages:     int(math.Ceil(float64(totalCount) / float64(recordsPerPage))),
		},
		Hackers: make([]*app.HackerItem, capacity),
	}
	i := 0
	for rows.Next() {
		var id int
		var name string
		err = rows.Scan(&id, &name)
		if err != nil {
			return nil, err
		}
		paging.Hackers[i] = &app.HackerItem{
			ID:   id,
			Name: name,
		}
		i++
	}
	return paging, nil
}

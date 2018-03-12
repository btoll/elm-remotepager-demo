package sql

import (
	mysql "database/sql"

	_ "github.com/go-sql-driver/mysql"
)

type CRUD interface {
	Create(db *mysql.DB) (interface{}, error)
	Update(db *mysql.DB) error
	Delete(db *mysql.DB) error
}

type Lister interface {
	List(db *mysql.DB) (interface{}, error)
}

type Pager interface {
	Page(db *mysql.DB) (interface{}, error)
}

type Reader interface {
	Read(db *mysql.DB) (interface{}, error)
}

func cleanup(db *mysql.DB) error {
	return db.Close()
}

func connect() (*mysql.DB, error) {
	return mysql.Open("mysql", ":@/?charset=utf8")
}

func Create(s CRUD) (interface{}, error) {
	db, err := connect()
	if err != nil {
		return -1, err
	}
	rec, err := s.Create(db)
	cleanup(db)
	return rec, err
}

func Read(s Reader) (interface{}, error) {
	db, err := connect()
	if err != nil {
		return nil, err
	}
	row, err := s.Read(db)
	cleanup(db)
	return row, err
}

func Update(s CRUD) error {
	db, err := connect()
	if err != nil {
		return err
	}
	err = s.Update(db)
	cleanup(db)
	return err
}

func Delete(s CRUD) error {
	db, err := connect()
	if err != nil {
		return err
	}
	err = s.Delete(db)
	cleanup(db)
	return err
}

func List(s Lister) (interface{}, error) {
	db, err := connect()
	if err != nil {
		return nil, err
	}
	coll, err := s.List(db)
	cleanup(db)
	return coll, err
}

func Page(p Pager) (interface{}, error) {
	//	db, err := connect()
	//	if err != nil {
	//		return nil, err
	//	}
	//	coll, err := p.Page(db)
	//	if err != nil {
	//		return nil, err
	//	}
	//	cleanup(db)
	//	return coll, nil
	return nil, nil
}

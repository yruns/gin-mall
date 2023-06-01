package model

type BasePage struct {
	PageNum  int `form:"pageNum"`
	PageSize int `form:"pageSize"`
}

type PageResult struct {
	Data  interface{} `json:"data" form:"data"`
	Total int64       `json:"total" form:"total"`
}

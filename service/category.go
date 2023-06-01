package service

import (
	"gin-mall/database"
	"gin-mall/model"
	"gin-mall/pkg/response"
)

type CategoryService struct {
	Name string `json:"name" form:"name"`
}

func (s *CategoryService) ListCategory() *response.Response {
	var categories []model.Category

	err := database.Mysql.Table("category").Find(&categories).Error
	if err != nil {
		return response.FailWithMessage("商品分类信息获取失败")
	}

	return response.OkWithData(categories)
}

func (s *CategoryService) CreateCategory() *response.Response {
	category := model.Category{CategoryName: s.Name}

	err := database.Mysql.Table("category").Create(&category).Error
	if err != nil {
		return response.FailWithMessage("商品分类创建失败")
	}

	return response.OkWithData(category)
}

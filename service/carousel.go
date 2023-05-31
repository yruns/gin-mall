package service

import (
	"gin-mall/database"
	"gin-mall/model"
	"gin-mall/pkg/response"
)

type CarouselService struct {
}

func (s *CarouselService) List() *response.Response {
	var carousels []model.Carousel
	err := database.Mysql.Table("carousel").Find(&carousels).Error
	if err != nil {
		return response.FailWithMessage("数据库查询失败")
	}

	return response.OkWithData(carousels)
}

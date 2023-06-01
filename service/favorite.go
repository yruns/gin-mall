package service

import (
	"gin-mall/database"
	"gin-mall/model"
	"gin-mall/pkg/response"
	"github.com/jinzhu/copier"
)

type FavoriteService struct {
	ProductId uint `json:"product_id" form:"product_id"`
	BossId    uint `json:"boss_id" form:"boss_id"`
}

func (s *FavoriteService) GetFavoriteByUserId(userId uint) *response.Response {
	var favorites []model.Favorite

	err := database.Mysql.Table("favorite").Where("user_id = ?", userId).Find(&favorites).Error
	if err != nil {
		return response.FailWithMessage("获取收藏夹信息失败")
	}

	return response.OkWithData(favorites)
}

func (s *FavoriteService) AddFavorite(userId uint) *response.Response {
	var favorite model.Favorite
	_ = copier.Copy(&favorite, s)
	favorite.UserId = userId

	err := database.Mysql.Table("favorite").Create(&favorite).Error
	if err != nil {
		return response.FailWithMessage("添加收藏失败")
	}

	return response.OkWithData(favorite)
}

func (s *FavoriteService) DeleteFavoriteById(id uint) *response.Response {
	var favorite model.Favorite
	err := database.Mysql.Table("favorite").Delete(&favorite, id).Error
	if err != nil {
		return response.FailWithMessage("删除收藏失败")
	}

	return response.OkWithData(favorite)
}

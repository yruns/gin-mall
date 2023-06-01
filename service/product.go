package service

import (
	"gin-mall/database"
	"gin-mall/model"
	"gin-mall/pkg/response"
	"github.com/jinzhu/copier"
)

type ProductService struct {
	Id            uint    `json:"id" form:"id"`
	Name          string  `json:"name" form:"name"`
	CategoryId    uint    `json:"category_id" form:"category_id"`
	Title         string  `json:"title" form:"title"`
	Info          string  `json:"info" form:"info"`
	ImgPath       string  `json:"img_path" form:"img_path"`
	Price         float64 `json:"price" form:"price"`
	DiscountPrice float64 `json:"discount_price" form:"discount_price"`
	OnSale        bool    `json:"on_sale" form:"on_sale"`
	Num           int     `json:"num" form:"num"`
	model.BasePage
}

func (s *ProductService) CreateProduct(userId uint, path string) *response.Response {
	var user model.User
	err := database.Mysql.Table("user").Where("id = ?", userId).Find(&user).Error
	if err != nil {
		return response.FailWithMessage("找不到该用户")
	}

	var product model.Product
	_ = copier.Copy(&product, s)
	product.ImgPath = path
	product.OnSale = true
	product.BossId = userId
	product.BossAvatar = user.Avatar
	product.BossName = user.NickName

	err = database.Mysql.Table("product").Create(&product).Error
	if err != nil {
		return response.FailWithMessage("商品信息保存失败")
	}

	return response.OkWithData(product)
}

func (s *ProductService) ListProduct(pageNum, pageSize int, categoryId uint) *response.Response {
	offset := (pageNum - 1) * pageSize
	var products []model.Product
	err := database.Mysql.Table("product").Where("category_id = ?", categoryId).
		Limit(pageSize).Offset(offset).Find(&products).Error
	if err != nil {
		return response.FailWithMessage("获取商品列表失败")
	}

	return response.OkWithData(products)
}

func (s *ProductService) SearchProduct(pageNum int, pageSize int, productName string) *response.Response {
	offset := (pageNum - 1) * pageSize
	var products []model.Product
	productName = "%" + productName + "%"
	err := database.Mysql.Table("product").
		Where("name Like ? OR info LIKE ? OR title LIKE ?", productName, productName, productName).
		Limit(pageSize).Offset(offset).Find(&products).Error
	if err != nil {
		return response.FailWithMessage("获取商品列表失败")
	}

	return response.OkWithData(products)
}

package service

import (
	"gin-mall/database"
	"gin-mall/model"
	"gin-mall/pkg/response"
	"github.com/jinzhu/copier"
)

type ProductService struct {
	Id            int64   `json:"id" form:"id"`
	Name          string  `json:"name" form:"name"`
	CategoryId    int64   `json:"category_id" form:"category_id"`
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
	tx := database.Mysql.Begin() // 创建事务

	var user model.User
	err := tx.Table("user").Where("id = ?", userId).Find(&user).Error
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

	err = tx.Table("product").Create(&product).Error
	if err != nil {
		tx.Rollback()
		return response.FailWithMessage("商品信息保存失败")
	}

	productImg := model.ProductImg{
		ProductId: product.ID,
		ImgPath:   path,
	}
	err = database.Mysql.Table("product_img").Create(&productImg).Error
	if err != nil {
		tx.Rollback()
		return response.FailWithMessage("商品图片保存失败")
	}

	tx.Commit() // 提交事务
	return response.OkWithData(product)
}

func (s *ProductService) ListProduct(pageNum, pageSize int, categoryId int64) *response.Response {
	offset := (pageNum - 1) * pageSize
	var products []model.Product
	var total int64

	// 分页查询
	database.Mysql.Table("product").Count(&total)
	err := database.Mysql.Table("product").Where("category_id = ?", categoryId).
		Limit(pageSize).Offset(offset).Find(&products).Error
	if err != nil {
		return response.FailWithMessage("获取商品列表失败")
	}

	return response.OkWithData(model.PageResult{
		Data:  products,
		Total: total,
	})
}

func (s *ProductService) SearchProduct(pageNum int, pageSize int, productName string) *response.Response {
	offset := (pageNum - 1) * pageSize
	var products []model.Product
	var total int64

	// 分页查询
	database.Mysql.Table("product").Count(&total)
	productName = "%" + productName + "%"
	err := database.Mysql.Table("product").
		Where("name Like ? OR info LIKE ? OR title LIKE ?", productName, productName, productName).
		Limit(pageSize).Offset(offset).Find(&products).Error
	if err != nil {
		return response.FailWithMessage("获取商品列表失败")
	}

	return response.OkWithData(model.PageResult{
		Data:  products,
		Total: total,
	})
}

func (s *ProductService) QueryProductById(id uint) *response.Response {
	var product model.Product
	err := database.Mysql.Table("product").Where("id = ?", id).Find(&product).Error
	if err != nil {
		return response.FailWithMessage("商品查询失败")
	}

	return response.OkWithData(product)
}

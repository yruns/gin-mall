package database

import (
	"fmt"
	"gin-mall/model"
)

func migration() {
	err := Mysql.Set("gorm.table_options", "charset=utf8mb4").
		AutoMigrate(
			&model.User{},
			&model.Address{},
			&model.Admin{},
			&model.Carousel{},
			&model.Cart{},
			&model.Category{},
			&model.Favorite{},
			&model.Notice{},
			&model.Order{},
			&model.Product{},
			&model.ProductImg{},
		)
	if err != nil {
		fmt.Println("自动迁移失败")
	}

	return
}

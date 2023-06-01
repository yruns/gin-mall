package model

import (
	"gorm.io/gorm"
)

type Product struct {
	gorm.Model
	Name          string
	CategoryId    uint
	Title         string
	Info          string
	ImgPath       string
	Price         float64
	DiscountPrice float64
	OnSale        bool `gorm:"default:false"`
	Num           uint
	BossId        uint
	BossName      string
	BossAvatar    string
}

//func (p *Product) GetView() int {
//	result, _ := database.Redis.Get(context.Background(), "product:view:"+strconv.Itoa(int(p.ID))).Result()
//	count, _ := strconv.Atoi(result)
//	return count
//}
//
//func (p *Product) AddView() {
//	database.Redis.Incr(context.Background(), "product:view:"+strconv.Itoa(int(p.ID)))
//	database.Redis.ZIncrBy(context.Background(), "product:rank", 1.0,
//		"product:view:"+strconv.Itoa(int(p.ID)))
//}

package model

import "gorm.io/gorm"

type Product struct {
	gorm.Model
	Name          string
	Category      uint
	Title         string
	Info          string
	ImgPath       string
	Price         float64
	DiscountPrice string
	OnSale        bool `gorm:"default:false"`
	Num           uint
	BossId        uint
	BossName      string
	BossAvatar    string
}

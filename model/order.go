package model

import "gorm.io/gorm"

type Order struct {
	gorm.Model
	UserId    uint `gorm:"not null"`
	Product   uint `gorm:"not null"`
	BossId    uint `gorm:"not null"`
	AddressId uint `gorm:"not null"`
	Num       int
	OrderNum  uint
	Type      uint // 1未支付 2已支付
	Money     float64
}

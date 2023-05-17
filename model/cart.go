package model

import "gorm.io/gorm"

type Cart struct {
	gorm.Model
	UserId    uint `gorm:"not null"`
	ProductId uint `gorm:"not null"`
	BossId    uint `gorm:"not null"`
	Num       uint `gorm:"not null"`
	Max       uint `gorm:"not null"`
	Check     bool
}

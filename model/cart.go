package model

import "gorm.io/gorm"

type Cart struct {
	gorm.Model
	UserId    uint  `gorm:"not null"`
	ProductId int64 `gorm:"not null"`
	BossId    int64 `gorm:"not null"`
	Num       int64 `gorm:"not null"`
	Max       int64 `gorm:"not null"`
	Check     bool
}

package model

import "gorm.io/gorm"

type Favorite struct {
	gorm.Model
	UserId    uint  `gorm:"not null"`
	ProductId int64 `gorm:"not null"`
	BossId    int64 `gorm:"not null"`
}

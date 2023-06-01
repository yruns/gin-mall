package utils

import (
	"github.com/gin-gonic/gin"
	"strconv"
)

func Str2Uint(s string) (uint, error) {
	parseUint, err := strconv.ParseUint(s, 10, 64)
	return uint(parseUint), err
}

func Str2Int64(s string) (int64, error) {
	parseInt, err := strconv.ParseInt(s, 10, 64)
	return parseInt, err
}

func GetUserIdFromHeader(c *gin.Context) uint {
	userId, _ := c.Get("userId")
	return userId.(uint)
}

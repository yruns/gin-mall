package v1

import (
	"gin-mall/pkg/response"
	"gin-mall/pkg/utils"
	"gin-mall/service"
	"github.com/gin-gonic/gin"
	"net/http"
)

func ShowFavorite(c *gin.Context) {
	userId := utils.GetUserIdFromHeader(c)

	var favoriteService service.FavoriteService
	res := favoriteService.GetFavoriteByUserId(userId)

	response.Result(res, c)
}

func AddFavorite(c *gin.Context) {
	userId := utils.GetUserIdFromHeader(c)

	var favoriteService service.FavoriteService
	if err := c.ShouldBind(&favoriteService); err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "参数绑定失败", c)
		return
	}

	res := favoriteService.AddFavorite(userId)
	response.Result(res, c)
}

func DeleteFavorite(c *gin.Context) {
	id, _ := utils.Str2Uint(c.Param("id"))
	var favoriteService service.FavoriteService

	res := favoriteService.DeleteFavoriteById(id)
	response.Result(res, c)
}

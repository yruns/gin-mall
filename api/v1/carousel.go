package v1

import (
	"gin-mall/pkg/response"
	"gin-mall/pkg/utils"
	"gin-mall/service"
	"github.com/gin-gonic/gin"
	"net/http"
)

func ListCarousel(c *gin.Context) {

	var carouselService service.CarouselService

	if err := c.ShouldBind(&carouselService); err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "参数绑定失败", c)
	}

	res := carouselService.List()
	utils.Logger.Info("Carousel hit！！！", res)
	response.Result(res, c)
}

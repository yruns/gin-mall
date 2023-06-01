package v1

import (
	"gin-mall/pkg/response"
	"gin-mall/service"
	"github.com/gin-gonic/gin"
	"net/http"
)

func ListCategory(c *gin.Context) {
	var categoryService service.CategoryService

	res := categoryService.ListCategory()
	response.Result(res, c)
}

func CreateCategory(c *gin.Context) {
	var categoryService service.CategoryService

	if err := c.ShouldBind(&categoryService); err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "参数绑定失败", c)
		return
	}

	res := categoryService.CreateCategory()
	response.Result(res, c)
}

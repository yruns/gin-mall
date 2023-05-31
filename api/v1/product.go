package v1

import (
	"gin-mall/pkg/response"
	"gin-mall/service"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"net/http"
	"strings"
)

func CreateProduct(c *gin.Context) {

	file, err := c.FormFile("file")
	userId, _ := c.Get("userId")

	var productService service.ProductService
	if err := c.ShouldBind(&productService); err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "参数绑定失败", c)
		return
	}

	// 保存文件到本地
	uuidResult, _ := uuid.NewRandom()
	fileType := file.Filename[strings.LastIndex(file.Filename, "."):]
	fileName := uuidResult.String() + fileType
	localPath := "./static/imgs/product" + fileName
	err = c.SaveUploadedFile(file, localPath)
	if err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "图片保存失败", c)
		return
	}

	res := productService.CreateProduct(userId.(uint), localPath)
	response.Result(res, c)
}

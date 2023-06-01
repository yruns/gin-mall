package v1

import (
	"gin-mall/pkg/response"
	"gin-mall/service"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"net/http"
	"strconv"
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
	localPath := "./static/imgs/product/" + fileName
	err = c.SaveUploadedFile(file, localPath)
	if err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "图片保存失败", c)
		return
	}

	res := productService.CreateProduct(userId.(uint), localPath)
	response.Result(res, c)
}

func ListProduct(c *gin.Context) {
	var productService service.ProductService

	pageSize, e1 := strconv.Atoi(c.Query("pageSize"))
	pageNum, e2 := strconv.Atoi(c.Query("pageNum"))
	categoryId, e3 := strconv.ParseUint(c.Query("categoryId"), 10, 32)
	if e1 != nil || e2 != nil || e3 != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "参数错误", c)
		return
	}

	res := productService.ListProduct(pageNum, pageSize, uint(categoryId))
	response.Result(res, c)
}

func SearchProduct(c *gin.Context) {
	var productService service.ProductService

	pageSize, e1 := strconv.Atoi(c.Query("pageSize"))
	pageNum, e2 := strconv.Atoi(c.Query("pageNum"))
	productName := c.Query("productName")
	if e1 != nil || e2 != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "参数错误", c)
		return
	}

	res := productService.SearchProduct(pageNum, pageSize, productName)
	response.Result(res, c)
}

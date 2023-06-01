package routes

import (
	api "gin-mall/api/v1"
	"gin-mall/middleware"
	"github.com/gin-gonic/gin"
	"net/http"
)

func NewRouter() *gin.Engine {
	r := gin.Default()

	// 全局中间件
	r.Use(middleware.Cors())
	// 设置静态资源路径
	r.StaticFS("/static", http.Dir("./static"))
	// 设置路由组
	v1 := r.Group("/api/v1")
	{
		v1.GET("/ping", func(c *gin.Context) {
			c.JSON(http.StatusOK, gin.H{
				"message": "pong",
			})
		})

		// 用户操作
		v1.POST("/user/register", api.UserRegister)
		v1.POST("/user/login", api.UserLogin)

		// 轮播图
		v1.GET("/carousels", api.ListCarousel)
		v1.GET("/product/list", api.ListProduct)
		v1.GET("/product/search", api.SearchProduct)
		v1.GET("/product/:id", api.ShowProduct)
		v1.GET("/category/list", api.ListCategory)
		v1.PUT("/category", api.CreateCategory)

		authed := v1.Group("/")                 // 需要登录操作
		authed.Use(middleware.AuthMiddleware()) // jwt鉴权
		authed.PUT("/user", api.UserUpdate)
		authed.POST("/user/upload", api.UploadAvatar)
		authed.POST("/email/code", api.SendEmail)
		authed.GET("/email/verify", api.VerifyEmail)

		// 商品操作
		authed.POST("/product", api.CreateProduct)

	}
	return r
}

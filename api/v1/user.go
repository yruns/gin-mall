package v1

import (
	"gin-mall/database"
	"gin-mall/pkg/response"
	"gin-mall/pkg/utils"
	"gin-mall/service"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"net/http"
	"strconv"
	"strings"
)

func UserRegister(c *gin.Context) {
	var userRegister service.UserService

	if err := c.ShouldBind(&userRegister); err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "参数解析失败", c)
		return
	}

	res := userRegister.Register()
	response.Result(res, c)
}

func UserLogin(c *gin.Context) {
	var userLogin service.UserService

	if err := c.ShouldBind(&userLogin); err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "登录失败", c)
		return
	}

	res, user := userLogin.Login()
	if user == nil {
		// 登录失败，提前返回
		response.Result(res, c)
		return
	}
	// 签发token
	token, err := utils.GenerateToken(user.ID, user.Username, 0)
	if err != nil {
		response.FailWithStatusCode(http.StatusUnauthorized, err.Error(), c)
		return

	}

	c.Header("Authorization", token)
	c.Header("Access-Control-Expose-Headers", "Authorization")
	response.Result(res, c)
}

func UserUpdate(c *gin.Context) {
	var userUpdate service.UserService

	if err := c.ShouldBind(&userUpdate); err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "参数绑定失败", c)
		return
	}

	// 获取用户id
	userId, _ := c.Get("userId")
	res := userUpdate.Update(userId.(int64))
	response.Result(res, c)
}

func UploadAvatar(c *gin.Context) {
	file, err := c.FormFile("file")
	if err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "图片上传失败", c)
		return
	}

	// 保存文件到本地
	uuidResult, _ := uuid.NewRandom()
	fileType := file.Filename[strings.LastIndex(file.Filename, "."):]
	fileName := uuidResult.String() + fileType
	localPath := "./static/imgs/" + fileName
	err = c.SaveUploadedFile(file, localPath)
	if err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "图片保存失败", c)
		return
	}

	// 修改数据库中信息
	userId, _ := c.Get("userId")
	userId = userId.(int64)

	err = database.Mysql.Table("user").Where("id = ?", userId).Update("avatar", localPath).Error
	if err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "图片路径保存失败", c)
		return
	}

	response.Result(response.Ok(), c)
}

func SendEmail(c *gin.Context) {
	var emailService service.EmailService

	if err := c.ShouldBind(&emailService); err != nil {
		response.FailWithStatusCode(http.StatusBadRequest, "参数绑定失败", c)
		return
	}

	userId, _ := c.Get("userId")

	res := emailService.SendEmail(userId.(uint))
	response.Result(res, c)
}

func VerifyEmail(c *gin.Context) {

	userId, _ := c.Get("userId")

	codeFromUser := c.Query("code")
	codeFromDB, _ := database.Redis.Get(c, "user:verify:"+strconv.Itoa(int(userId.(uint)))).Result()

	if strings.EqualFold(codeFromDB, codeFromUser) {
		response.Result(response.Ok(), c)
	} else {
		response.FailWithStatusCode(http.StatusOK, "验证失败", c)
	}
}

package service

import (
	"context"
	"fmt"
	"gin-mall/conf"
	"gin-mall/database"
	"gin-mall/model"
	"gin-mall/pkg/response"
	"gin-mall/pkg/utils"
	"github.com/jinzhu/copier"
	"gopkg.in/gomail.v2"
	"strconv"
	"time"
)

type UserService struct {
	NickName string `json:"nick_name" form:"nick_name"`
	Username string `json:"username" form:"username"`
	Password string `json:"password" form:"password"`
	Avatar   string `json:"avatar" form:"avatar"`
	Key      string `json:"key" form:"key"` // 前端验证
}

type EmailService struct {
	Email    string `json:"email" form:"email"`
	Password string `json:"password" form:"password"`
	// 1:绑定邮箱  2:解绑邮箱	 3:更改密码
	OperationType int64 `json:"operation_type" form:"operation_type"`
}

var EMAILNOTICE = [3]string{
	"您正在绑定邮箱",
	"您正在解绑邮箱",
	"您正在更改密码",
}

func (s *EmailService) SendEmail(userId uint) *response.Response {

	verifyCode := utils.GenerateEmailVerifyCode()

	// 发送邮件
	notice := fmt.Sprintf("%s，验证码为：<h2>%s</h2>若非本人操作请忽略该信息。", EMAILNOTICE[s.OperationType], verifyCode)
	m := gomail.NewMessage()
	m.SetHeader("From", m.FormatAddress(conf.SmtpUser, "Go Mall"))
	m.SetHeader("To", s.Email)
	m.SetHeader("Subject", "Go Mall邮箱验证")
	m.SetBody("text/html", notice)
	d := gomail.NewDialer(conf.SmtpHost, 465, conf.SmtpUser, conf.SmtpPass)

	if err := d.DialAndSend(m); err != nil {
		utils.Logger.Info(err.Error())
		return response.FailWithMessage("邮件发送失败，请重试")
	}

	// 写入redis
	database.Redis.SetEx(context.Background(), "user:verify:"+strconv.Itoa(int(userId)), verifyCode, time.Minute*3)

	return response.Ok()
}

func (s *UserService) Register() *response.Response {
	if s.Key == "" || len(s.Key) != 16 {
		return response.FailWithMessage("密钥错误")
	}

	// 对称加密
	utils.Encrypt.SetKey(s.Key)

	// 注册逻辑
	var user model.User
	// 1.判断该用户名是否已存在
	rowsAffected := database.Mysql.Table("user").Where("username = ?", s.Username).Find(&user).RowsAffected
	if rowsAffected > 0 {
		return response.FailWithMessage("用户名已存在")
	}

	user = model.User{
		Username: s.Username,
		NickName: s.NickName,
		Status:   model.Active,
		Avatar:   "imgs/avatar.jpg",
		Money:    utils.Encrypt.AesEncoding("10000"), // 对初始金额的加密
	}

	err := user.SetPassword(s.Password)
	if err != nil {
		return response.FailWithMessage("密码加密失败")
	}

	// 2.向数据库写入新用户
	err = database.Mysql.Table("user").Create(&user).Error
	if err != nil {
		return response.FailWithMessage(err.Error())
	}

	return response.Ok()
}

func (s *UserService) Login() (*response.Response, *model.User) {
	var user model.User

	// 验证账号密码
	affected := database.Mysql.Table("user").Where("username = ?", s.Username).
		Find(&user).RowsAffected
	if affected == 0 {
		return response.FailWithMessage("账号不存在"), nil
	}

	// 从数据库中获取hash后的密码
	hashedPasswordFromDB := user.PasswordDigest
	// 验证密码
	flag := user.CheckPassword(s.Password, hashedPasswordFromDB)
	if !flag {
		return response.FailWithMessage("密码错误"), nil
	}

	return response.OkWithData(user), &user
}

func (s *UserService) Update(userId int64) *response.Response {
	var user model.User
	_ = copier.Copy(&user, s)

	affected := database.Mysql.Table("user").Where("id = ?", userId).Updates(user).RowsAffected // gorm默认只会更新非空字段，0/false/""都将被忽略
	if affected == 0 {
		return response.FailWithMessage("用户信息更新失败")
	}

	// 将该用户查出用于返回
	database.Mysql.Table("user").Where("id = ?", userId).Find(&user)
	return response.OkWithData(user)
}

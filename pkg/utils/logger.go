package utils

import (
	"fmt"
	"github.com/sirupsen/logrus"
	"io"
	"log"
	"os"
	"path"
	"time"
)

var Logger *logrus.Logger

func init() {
	src, _ := setOutput()
	if Logger != nil {
		Logger.Out = src // 设置日志输入路径
		return
	}

	// 实例化
	logger := logrus.New()
	logger.Out = src
	logger.SetLevel(logrus.DebugLevel)

	// 设置日志格式和输出方式
	formatter := &logrus.TextFormatter{
		ForceColors:     true,                  // 强制使用颜色
		FullTimestamp:   true,                  // 显示完整时间戳
		TimestampFormat: "2006-01-02 15:04:05", // 时间戳格式
	}
	writer := io.MultiWriter(src, os.Stdout)

	// 设置日志记录器的输出
	logger.SetFormatter(formatter)
	logger.SetOutput(writer)
	Logger = logger
}

func setOutput() (*os.File, error) {
	now := time.Now()
	logFilePath := ""
	if dir, err := os.Getwd(); err == nil { // 获取当前目录
		logFilePath = dir + "/logs/"
	}

	logFileName := now.Format("2006-01-02") + ".log"
	// 日志文件
	fileName := path.Join(logFilePath, logFileName)
	_, err := os.Stat(fileName)
	if os.IsNotExist(err) {
		if err = os.MkdirAll(logFilePath, 0777); err != nil {
			log.Print(err.Error() + "####")
			return nil, err
		}
	}

	err = os.Chmod(fileName, 0666)
	src, err := os.OpenFile(fileName, os.O_APPEND|os.O_RDWR|os.O_CREATE, os.ModeAppend)
	fmt.Println(err)
	return src, err
}

package main

import (
	"gin-mall/conf"
	"gin-mall/routes"
	"log"
)

func main() {
	conf.Init()

	router := routes.NewRouter()

	err := router.Run(conf.HttpPort)
	if err != nil {
		log.Fatal("端口监听失败")
	}
}

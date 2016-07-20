package main

import (
	"fmt"
	"github.com/golang/protobuf/proto"
)

func main() {
	ex := &Example{
		Mybool:   true,
		Number:   123.4567,
		Mystring: "lorem ipsum",
		Myarray:  []string{"a", "b", "c"},
		Myhash:   map[string]string{"key": "value"},
	}

	data, err := proto.Marshal(ex)
	if err != nil {
		panic(err)
	}
	fmt.Println(string(data))
}

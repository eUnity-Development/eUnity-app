package MediaEncoder

import (
	"bytes"
	"fmt"
	"io"
	"mime/multipart"
	"os"

	// "github.com/h2non/bimg"
	"github.com/h2non/bimg"
)

// bimg required vips as en enviroment dependency so it can only run on linux or a docker container
// it is a fast library for image processing

func SaveToWebp(fileHeader *multipart.FileHeader, image_id string, user_id string) error {
	err := saveToWebp(fileHeader, image_id, user_id)
	if err != nil {
		return err
	}
	return nil
}

// private save to webp function
func saveToWebp(fileHeader *multipart.FileHeader, image_id string, user_id string) error {
	//convert image to webp
	file, err := fileHeader.Open()
	if err != nil {
		return err
	}
	defer file.Close()

	//multipart.File to buffer
	buffer := bytes.NewBuffer(nil)
	if _, err := io.Copy(buffer, file); err != nil {
		return err
	}

	newImage, err := bimg.NewImage(buffer.Bytes()).Process(
		bimg.Options{
			Type:    bimg.WEBP,
			Quality: 99,
			//Lossless: true,
		},
	)
	if err != nil {
		return err
	}

	// Ensure the directory exists
	dirPath := "images/" + user_id
	if err := os.MkdirAll(dirPath, os.ModePerm); err != nil {
		fmt.Println(err)
		return err
	}

	//buffer to multipart.File
	err = bimg.Write("images/"+user_id+"/"+image_id+".webp", newImage)
	if err != nil {
		fmt.Println(err)
		return err
	}

	return nil
}

// disabling for now
// func DefaultSaveToWebp(fileHeader *multipart.FileHeader, image_id string, user_id string) error {
// 	file, err := fileHeader.Open()
// 	if err != nil {
// 		return err
// 	}
// 	defer file.Close()

// 	//multipart.File to buffer
// 	buffer := bytes.NewBuffer(nil)
// 	if _, err := io.Copy(buffer, file); err != nil {
// 		return err
// 	}

// 	//buffer to file
// 	err = os.WriteFile("images/"+user_id+"/"+image_id+".webp", buffer.Bytes(), 0666)
// 	if err != nil {
// 		return err
// 	}

// 	return nil
// }

package MediaEncoder

import (
	"bytes"
	"io"
	"mime/multipart"
	"os"

	"github.com/h2non/bimg"
	"github.com/joho/godotenv"
)

// bimg required vips as en enviroment dependency so it can only run on linux or a docker container
// it is a fast library for image conversion
var bimgEnabled bool

func init() {
	godotenv.Load()
	enabled := os.Getenv("BIMG_ENABLED")
	if enabled == "true" {
		bimgEnabled = true
	} else {
		bimgEnabled = false

	}
}

func SaveToWebp(fileHeader *multipart.FileHeader, image_id string, user_id string) error {
	//convert image to webp
	switch bimgEnabled {
	case true:
		err := saveToWebp(fileHeader, image_id, user_id)
		if err != nil {
			return err
		}
		return nil
	case false:
		err := slowSaveToWebp(fileHeader, image_id, user_id)
		if err != nil {
			return err
		}
		return nil
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

	//buffer to multipart.File
	err = bimg.Write("images/"+user_id+"/"+image_id+".webp", newImage)
	if err != nil {
		return err
	}

	return nil
}

func slowSaveToWebp(fileHeader *multipart.FileHeader, image_id string, user_id string) error {
	return nil
}

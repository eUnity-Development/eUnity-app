package main

import (
	"fmt"
	_ "image/jpeg"
	_ "image/png"
	"os"
	"time"

	"github.com/h2non/bimg"
)

//test converting jpeg to avif to see compression ration and quality

func main() {
	//import the image
	start := time.Now()

	buffer, err := bimg.Read("image.png")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
	}

	format := "avif"

	newImage, err := bimg.NewImage(buffer).Process(
		bimg.Options{
			Type:     bimg.WEBP,
			Quality:  95,
			Lossless: true,
			Speed:    8,
		},
	)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
	}

	if bimg.NewImage(newImage).Type() == format {
		fmt.Fprintln(os.Stderr, "The image was converted into "+format+" format")
	}

	//save the image
	err = bimg.Write("image."+format, newImage)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
	}

	fmt.Println("Conversion took: ", time.Since(start))

	// src, err := os.Open("image.png")
	// if err != nil {
	// 	log.Fatalf("Can't open sorce file: %v", err)
	// }

	// defer src.Close()

	// img, format, err := image.Decode(src)
	// if err != nil {
	// 	log.Fatalf("Can't decode source file: %v", err)
	// }

	// log.Printf("Successfully decoded image with format: %s", format)

	// dst, err := os.Create("destination.avif")
	// if err != nil {
	// 	log.Fatalf("Can't create destination file: %v", err)
	// }

	// var subSampleRation image.YCbCrSubsampleRatio = image.YCbCrSubsampleRatio420

	// err = avif.Encode(dst, img, &avif.Options{
	// 	Threads:        0,
	// 	Speed:          4,
	// 	Quality:        avif.MinQuality,
	// 	SubsampleRatio: &subSampleRation,
	// },
	// )
	// if err != nil {
	// 	log.Fatalf("Can't encode source image: %v", err)
	// }

	// log.Printf("Encoded AVIF at %s", dst.Name())

}

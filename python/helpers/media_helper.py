from imagekitio import ImageKit
from imagekitio.models.UploadFileRequestOptions import UploadFileRequestOptions
import base64
import os
from dotenv import load_dotenv
from models.images import Image

load_dotenv()


imagekit = ImageKit(
    public_key=os.getenv("IMAGEKIT_PUBLIC_KEY"),
    private_key=os.getenv("IMAGEKIT_PRIVATE_KEY"),
    url_endpoint=os.getenv("IMAGEKIT_URL_ENDPOINT"),
)


class ImageHelper:

    ##the folder corresponds to the userID or the reportID
    @staticmethod
    async def uploadImage(img, id, folder=""):
        imgstr = base64.b64encode(await img.read())
        upload = imagekit.upload_file(
            file=imgstr,
            file_name=id,
            options=UploadFileRequestOptions(
                response_fields=["is_private_file", "custom_metadata", "tags"],
                folder="eunity/" + folder,
                is_private_file=False,
            ),
        )
        print(upload.__dict__)
        print(upload.response_metadata.raw)
        image = Image(
            url=upload.response_metadata.raw["url"],
            image_id=upload.response_metadata.raw["fileId"],
            folder=folder,
        )

        return image

    @staticmethod
    def deleteImage(fileId):
        delete = imagekit.delete_file(fileId)
        return delete.response_metadata.raw
    
    @staticmethod
    def get_image_url(fileId):
        return imagekit.get_file_details(fileId).response_metadata.raw["url"]

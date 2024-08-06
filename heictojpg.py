from PIL import Image

import pillow_heif

heif_file = pillow_heif.read(r"D:\backup\iPhone\iPhone 7\20211203\DCIM\201812_b\")

image = Image.frombytes(
    heif_file.mode,
    heif_file.size,
    heif_file.data,
    "raw",

)

image.save(r"D:\backup\iPhone\iPhone 7\20211203\DCIM\201812_b\jpg\picture_name.jpg", format("jpg"))
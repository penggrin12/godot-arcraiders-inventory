class_name Utils

static var debug_32 = generate_debug_texture(32, 32)

static func generate_debug_texture(width: int, height: int) -> Texture2D:
	var image = Image.create_empty(width, height, false, Image.FORMAT_RGB565)
	image.fill_rect(Rect2i(0, 0, width/2, height/2), Color.PURPLE)
	image.fill_rect(Rect2i(width/2, height/2, width, height), Color.PURPLE)
	return ImageTexture.create_from_image(image)

extends BaseMenu

@onready var _movie_cover: TextureButton = %MovieCover
@onready var _file_dialog: FileDialog = %FileDialog


func _change_texture(path: String) -> void:
	_movie_cover.texture_normal = _load_external_tex(path)


func _load_external_tex(path) -> ImageTexture:
	var tex_file = FileAccess.open(path, FileAccess.READ)
	var bytes = tex_file.get_buffer(tex_file.get_len())
	var img = Image.new()
	img.load_png_from_buffer(bytes)
	var imgtex = ImageTexture.create_from_image(img)
	tex_file.close()
	return imgtex


func _on_movie_cover_pressed() -> void:
	_file_dialog.visible = true


func _on_file_dialog_file_selected(path: String) -> void:
	_change_texture(path)

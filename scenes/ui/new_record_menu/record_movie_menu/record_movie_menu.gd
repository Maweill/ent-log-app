extends BaseMenu

@onready var _movie_name: LineEdit = %MovieName

var _is_like: bool


func _on_dislike_pressed() -> void:
	_is_like = false


func _on_like_pressed() -> void:
	_is_like = true


func _on_save_pressed() -> void:
	var movie_model: MovieModel = MovieModel.new()
	movie_model.id = 1
	movie_model.is_like = _is_like
	movie_model.movie_name = _movie_name.text

	# save
	var json_data = JSON.stringify(movie_model.export_to_dict())
	var file := FileAccess.open("user://movie_model_%s" % movie_model.id, FileAccess.WRITE)
	file.store_string(json_data)
	file.close()

	# load
	file = FileAccess.open("user://movie_model_%s" % movie_model.id, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	var data := JSON.parse_string(content) as Dictionary
	var new_movie_model := MovieModel.new()
	new_movie_model.import_from_dict(data)
	print(new_movie_model.movie_name)

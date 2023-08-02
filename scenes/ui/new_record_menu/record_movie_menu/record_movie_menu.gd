extends BaseMenu

@onready var _movie_name: LineEdit = %MovieName

var _is_like: bool


func _on_dislike_pressed() -> void:
	_is_like = false


func _on_like_pressed() -> void:
	_is_like = true


func _on_save_pressed() -> void:
	var movie_model: MovieModel = MovieModel.new()
	movie_model.is_like = _is_like
	movie_model.movie_name = _movie_name.text
	ModelStorage.add_model(movie_model)

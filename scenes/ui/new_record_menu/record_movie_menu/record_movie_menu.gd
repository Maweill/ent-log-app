extends BaseMenu

@onready var _movie_name: LineEdit = %MovieName
@onready var _save_button: Button = %Save

var _is_like = null

func _ready() -> void:
	_save_button.disabled = true


func _on_movie_name_text_changed(_new_text: String) -> void:
		_try_enable_save_button()


func _on_dislike_pressed() -> void:
	_is_like = false
	_try_enable_save_button()


func _on_like_pressed() -> void:
	_is_like = true
	_try_enable_save_button()


func _on_save_pressed() -> void:
	var movie_model: MovieModel = MovieModel.new()
	movie_model.type = Enums.ModelType.MOVIE
	movie_model.is_like = _is_like
	movie_model.movie_name = _movie_name.text
	ModelStorage.add_model(movie_model)


func _try_enable_save_button() -> void:
	_save_button.disabled = _movie_name.text.is_empty() or _is_like == null

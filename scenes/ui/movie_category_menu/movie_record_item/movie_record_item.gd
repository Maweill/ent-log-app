extends Control

class_name  MovieRecordItem

@export var _like_texture: Texture2D
@export var _dislike_texture: Texture2D

@onready var _movie_name: Label = %MovieName
@onready var _movie_rating: TextureRect = %MovieRating

var _model: BaseModel

func configure(movie_model: MovieModel) -> void:
	_model = movie_model
	_movie_name.text = movie_model.movie_name
	_movie_rating.texture = _like_texture if movie_model.is_like else _dislike_texture


func _on_delete_self_pressed() -> void:
	ModelStorage.remove_model(_model)
	queue_free()

extends Control

class_name RecordItem

@export var _like_texture: Texture2D
@export var _dislike_texture: Texture2D

@onready var _name: Label = %Name
@onready var _rating: TextureRect = %Rating

var _model: BaseModel

func configure(movie_model: RecordModel) -> void:
	_model = movie_model
	_name.text = movie_model.name
	_rating.texture = _like_texture if movie_model.is_like else _dislike_texture


func _on_delete_self_pressed() -> void:
	ModelStorage.remove_model(_model)
	queue_free()

extends BaseMenu

@export var _movie_record_item_scene: PackedScene

@onready var _movies_records: VBoxContainer = %MoviesRecords

func _ready() -> void:
	var models: Array[BaseModel] = ModelStorage.get_models_of_type(Enums.ModelType.MOVIE, MovieModel)
	for movie_model in models:
		var movie_record_item := _movie_record_item_scene.instantiate() as MovieRecordItem
		_movies_records.add_child(movie_record_item)
		movie_record_item.configure(movie_model)

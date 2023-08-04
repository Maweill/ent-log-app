extends BaseModel

class_name MovieModel

var movie_name: String
var is_like: bool


func export_data() -> Dictionary:
	return {
		"id": id,
		"type": type,
		"movie_name": movie_name,
		"is_like": is_like
	}


func import_data(dict: Dictionary) -> void:
	id = dict.id
	type = dict.type
	movie_name = dict.movie_name
	is_like = dict.is_like

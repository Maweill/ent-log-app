extends BaseModel

class_name MovieModel

var id: int
var movie_name: String
var is_like: bool


func export_to_dict() -> Dictionary:
	return {
		"id": id,
		"movie_name": movie_name,
		"is_like": is_like
	}


func import_from_dict(dict: Dictionary) -> void:
	id = dict.id
	movie_name = dict.movie_name
	is_like = dict.is_like

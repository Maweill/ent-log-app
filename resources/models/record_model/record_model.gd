extends BaseModel

class_name RecordModel

var name: String
var is_like: bool

func export_data() -> Dictionary:
	return {
		"id": id,
		"created_unix_time": created_unix_time,
		"type": type,
		"name": name,
		"is_like": is_like
	}


func import_data(dict: Dictionary) -> void:
	id = dict.id
	created_unix_time = dict.created_unix_time
	type = dict.type
	name = dict.name
	is_like = dict.is_like

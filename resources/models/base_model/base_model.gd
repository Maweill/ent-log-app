class_name BaseModel

var id: int
var created_unix_time: float
var type: Enums.ModelType

func export_data() -> Dictionary:
		assert(false)
		return {}


@warning_ignore("unused_parameter")
func import_data(dict: Dictionary) -> void:
	assert(false)

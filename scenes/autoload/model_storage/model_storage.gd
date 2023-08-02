extends Node

const DIRECTORY_PATH: String = "user://models/"
const MODEL_FILE_PREFIX: String = "model_"
const LAST_ID_FILE_NAME: String = "last_id"

var _models_data: Dictionary = {}
var _last_id: int


func _init() -> void:
	var dir = DirAccess.open("user://")
	if not dir.dir_exists("models"):
		dir.make_dir("models")
	_load_all_models()
	_load_last_id()


func get_model(model_id: int, model_class) -> BaseModel:
	if model_id in _models_data.keys():
		var model_instance: BaseModel = model_class.new()
		var model_data: Dictionary = _models_data[model_id] as Dictionary
		model_instance.import_data(model_data)
		return model_instance
	else:
		return null


func add_model(model: BaseModel) -> int:
	_last_id += 1
	model.id = _last_id
	_models_data[model.id] = model.export_data()
	save_model(model)
	return model.id


func remove_model(model_id: int) -> void:
	if model_id not in _models_data.keys():
		return

	_models_data.erase(model_id)
	var dir := DirAccess.open(DIRECTORY_PATH)
	if dir.file_exists(str(model_id)):
		dir.remove(str(model_id))


func save_model(model: BaseModel) -> void:
	var json_data = JSON.stringify(model.export_data())
	var file = FileAccess.open(DIRECTORY_PATH + MODEL_FILE_PREFIX + str(model.id), FileAccess.WRITE)
	file.store_string(json_data)
	file.close()

	file = FileAccess.open(DIRECTORY_PATH + LAST_ID_FILE_NAME, FileAccess.WRITE)
	file.store_32(_last_id)


func _load_all_models() -> void:
	var dir := DirAccess.open(DIRECTORY_PATH)
	if dir == null:
		return
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.begins_with(MODEL_FILE_PREFIX):
			var file = FileAccess.open(DIRECTORY_PATH + file_name, FileAccess.READ)
			var content = file.get_as_text()
			file.close()
			var data = JSON.parse_string(content)
			_models_data[data.id] = data
		file_name = dir.get_next()


func _load_last_id() -> void:
	var file = FileAccess.open(DIRECTORY_PATH + LAST_ID_FILE_NAME, FileAccess.READ)
	if file == null:
		return

	_last_id = file.get_32()

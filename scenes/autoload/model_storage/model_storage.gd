extends Node

const MODELS_ROOT_DIRECTORY_PATH: String = "user://models/"
const LAST_ID_FILE_NAME: String = "last_id"

var _models_data_by_type: Dictionary = {} # { Enums.ModelType: { id: { data } } }
var _last_id: int

func _init() -> void:
	_make_dirs()
	_load_all_models()
	_load_last_id()


func add_model(model: BaseModel) -> int:
	_last_id += 1
	model.id = _last_id
	model.created_unix_time = Time.get_unix_time_from_system()
	_models_data_by_type[model.type][model.id] = model.export_data()
	save_model(model)
	return model.id


func remove_model(model_id: int, model_type: Enums.ModelType) -> void:
	if model_id not in _models_data_by_type[model_type].keys():
		return
	_models_data_by_type[model_type].erase(model_id)
	var dir := DirAccess.open(_get_dir_path(model_type))
	if dir.file_exists(str(model_id)):
		dir.remove(str(model_id))


func save_model(model: BaseModel) -> void:
	var json_data = JSON.stringify(model.export_data())
	var path = _get_dir_path(model.type) + str(model.id)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json_data)
	file.close()

	file = FileAccess.open(MODELS_ROOT_DIRECTORY_PATH + LAST_ID_FILE_NAME, FileAccess.WRITE)
	file.store_32(_last_id)


func get_models_of_type(model_type: Enums.ModelType, model_class) -> Array[BaseModel]:
	if model_type not in _models_data_by_type.keys():
		return []
	var result: Array[BaseModel] = []
	for model_data in _models_data_by_type[model_type].values():
		var model: BaseModel = model_class.new()
		model.import_data(model_data)
		result.append(model)
	return result


func get_model(model_id: int, model_class) -> BaseModel:
	var all_models_data: Dictionary = _get_all_models_data()
	if model_id not in all_models_data:
		return
	var model_instance: BaseModel = model_class.new()
	var model_data: Dictionary = all_models_data[model_id] as Dictionary
	model_instance.import_data(model_data)
	return model_instance


func _make_dirs() -> void:
	var dir = DirAccess.open("user://")
	if not dir.dir_exists("models"):
		dir.make_dir("models")
	dir = DirAccess.open(MODELS_ROOT_DIRECTORY_PATH)
	for model_type in Enums.ModelType.values():
		var dir_name := _get_dir_name(model_type)
		if not dir.dir_exists(dir_name):
			dir.make_dir(dir_name)


func _load_all_models() -> void:
	for model_type in Enums.ModelType.values():
		var dir_path := _get_dir_path(model_type)
		var dir := DirAccess.open(dir_path)
		if dir == null:
			return

		dir.list_dir_begin()
		var file_name = dir.get_next()
		_models_data_by_type[model_type] = {}
		while file_name != "":
			var file = FileAccess.open(dir_path + file_name, FileAccess.READ)
			var content = file.get_as_text()
			file.close()
			var data = JSON.parse_string(content)
			_models_data_by_type[model_type][data.id] = data
			file_name = dir.get_next()


func _load_last_id() -> void:
	var file = FileAccess.open(MODELS_ROOT_DIRECTORY_PATH + LAST_ID_FILE_NAME, FileAccess.READ)
	if file == null:
		return

	_last_id = file.get_32()


func _get_dir_path(model_type: Enums.ModelType) -> String:
	var result_path := "user://models/"
	match model_type:
		Enums.ModelType.MOVIE:
			result_path += "movies"
		Enums.ModelType.BOOK:
			result_path += "books"
		Enums.ModelType.MUSIC:
			result_path += "music"
		Enums.ModelType.GAME:
			result_path += "games"
	return result_path + "/"


func _get_dir_name(model_type: Enums.ModelType) -> String:
	var result_name: String
	match model_type:
		Enums.ModelType.MOVIE:
			result_name = "movies"
		Enums.ModelType.BOOK:
			result_name = "books"
		Enums.ModelType.MUSIC:
			result_name = "music"
		Enums.ModelType.GAME:
			result_name = "games"
	return result_name


func _get_all_models_data() -> Dictionary:
	var result_data := {}
	for model_type in Enums.ModelType.values():
		result_data += _models_data_by_type[model_type]
	return result_data

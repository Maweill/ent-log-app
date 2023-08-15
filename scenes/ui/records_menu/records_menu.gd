extends BaseMenu

@export var _record_item_scene: PackedScene

@onready var _records: VBoxContainer = %Records

var _model_type: Enums.ModelType

func configure(args: Array = []) -> void:
	_model_type = args[0]


func _ready() -> void:
	var models: Array[BaseModel] = ModelStorage.get_models_of_type(_model_type, RecordModel)
	models.sort_custom(func(a: BaseModel, b: BaseModel): return a.created_unix_time > b.created_unix_time)
	for model in models:
		var record_item := _record_item_scene.instantiate() as RecordItem
		_records.add_child(record_item)
		record_item.configure(model)

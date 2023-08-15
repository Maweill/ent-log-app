extends BaseMenu

@onready var _name: LineEdit = %Name
@onready var _save_button: Button = %Save
@onready var _category_option_button: OptionButton = %Category

var _is_like = null
var _category_name = null

func _ready() -> void:
	_save_button.disabled = true
	_init_category_button()


func _on_category_item_selected(index: int) -> void:
	_category_name = _category_option_button.get_item_text(index)
	_try_enable_save_button()


func _on_name_text_changed(_new_text: String) -> void:
		_try_enable_save_button()


func _on_dislike_pressed() -> void:
	_is_like = false
	_try_enable_save_button()


func _on_like_pressed() -> void:
	_is_like = true
	_try_enable_save_button()


func _on_save_pressed() -> void:
	_add_model()
	UiManager.show_menu(Enums.MenuType.RECORDS, [Enums.ModelType[_category_name]])


func _init_category_button() -> void:
	for category in Enums.ModelType:
		_category_option_button.add_item(category, Enums.ModelType[category] + 1)
	_category_name = _category_option_button.get_item_text(0)


func _add_model() -> void:
	var movie_model: RecordModel = RecordModel.new()
	movie_model.type = Enums.ModelType[_category_name]
	movie_model.is_like = _is_like
	movie_model.name = _name.text
	ModelStorage.add_model(movie_model)


func _try_enable_save_button() -> void:
	_save_button.disabled = _name.text.is_empty() or _is_like == null or _category_name == null

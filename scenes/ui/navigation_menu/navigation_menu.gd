extends BaseMenu

@export
var new_record_menu_scene: PackedScene

@onready var categories_button: Button = %Categories
@onready var calendar_button: Button = %Calendar
@onready var new_record_button: Button = %NewRecord
@onready var feed_button: Button = %Feed
@onready var settings_button: Button = %Settings

func _on_new_record_pressed() -> void:
	UiManager.show_menu(UiManager.MenuType.NEW_RECORD)

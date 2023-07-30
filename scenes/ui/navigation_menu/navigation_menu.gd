extends BaseMenu


func _on_new_record_pressed() -> void:
	UiManager.show_menu(Enums.MenuType.NEW_RECORD)

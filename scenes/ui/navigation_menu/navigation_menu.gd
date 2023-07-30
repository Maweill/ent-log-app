extends BaseMenu


func _on_new_record_pressed() -> void:
	UiManager.hide_all_menus()
	UiManager.show_menu(Enums.MenuType.NEW_RECORD)


func _on_categories_pressed() -> void:
	UiManager.hide_all_menus()
	UiManager.show_menu(Enums.MenuType.CATEGORIES)

extends BaseMenu


func _on_movies_pressed() -> void:
	UiManager.show_menu(Enums.MenuType.MOVIE_CATEGORY)

extends BaseMenu


func _on_movies_pressed() -> void:
	UiManager.show_menu(Enums.MenuType.RECORDS, [Enums.ModelType.MOVIE])


func _on_books_pressed() -> void:
	UiManager.show_menu(Enums.MenuType.RECORDS, [Enums.ModelType.BOOK])


func _on_music_pressed() -> void:
	UiManager.show_menu(Enums.MenuType.RECORDS, [Enums.ModelType.MUSIC])


func _on_games_pressed() -> void:
	UiManager.show_menu(Enums.MenuType.RECORDS, [Enums.ModelType.GAME])

extends Control

@export var _new_record_menu_scene: PackedScene
@export var _categories_menu_scene: PackedScene
@export var _record_movie_menu_scene: PackedScene
@export var _movie_category_scene: PackedScene

@onready var _menu_container: Control = %MenuScreen

var _current_menu_list: Array[BaseMenu]

func show_menu(menuType: Enums.MenuType):
	if (_current_menu and _current_menu.type == menuType):
		return

	match menuType:
		Enums.MenuType.NEW_RECORD:
			_current_menu_list.append(_instantiate_menu(_new_record_menu_scene))
		Enums.MenuType.CATEGORIES:
			_current_menu_list.append(_instantiate_menu(_categories_menu_scene))
		Enums.MenuType.RECORD_MOVIE:
			_current_menu_list.append(_instantiate_menu(_record_movie_menu_scene))
		Enums.MenuType.MOVIE_CATEGORY:
			_current_menu_list.append(_instantiate_menu(_movie_category_scene))
		_:
			printerr('wrong menu type')
			return
	_current_menu.type = menuType
	_menu_container.add_child(_current_menu)


func hide_all_menus():
	for menu in _current_menu_list:
		menu.hide_menu()

	_current_menu_list.clear()


func hide_current_menu():
	_current_menu.hide_menu()


func _instantiate_menu(menuScene: PackedScene) -> BaseMenu:
	return menuScene.instantiate() as BaseMenu


var _current_menu: BaseMenu:
	get:
		return _current_menu_list.back() if _current_menu_list.size() > 0 else null

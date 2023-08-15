extends Control

@export var _menu_scenes_with_type: Dictionary # {MenuType: PackedScene}

@onready var _menu_container: Control = %MenuScreen

var _current_menu_list: Array[BaseMenu]

func show_menu(menu_type: Enums.MenuType, args=[]):
	if (_current_menu and _current_menu.type == menu_type):
		return
	var menu_scene: PackedScene = _menu_scenes_with_type[menu_type]
	_current_menu_list.append(_instantiate_menu(menu_scene))
	_current_menu.type = menu_type
	_current_menu.configure(args)
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

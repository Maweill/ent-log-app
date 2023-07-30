extends Control

@export var _new_record_menu_scene: PackedScene
@export var _menu_container: Control

var _current_menu: BaseMenu

func show_menu(menuType: Enums.MenuType):
	if (_current_menu and _current_menu.type == menuType):
		return
	
	match menuType:
		Enums.MenuType.NEW_RECORD:
			_current_menu = _new_record_menu_scene.instantiate() as BaseMenu
		_:
			printerr('wrong menu type')
	_current_menu.type = menuType
	_menu_container.add_child(_current_menu)
	_current_menu.show_menu()

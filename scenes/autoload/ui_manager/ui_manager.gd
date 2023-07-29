extends Control

enum MenuType {
	NEW_RECORD
}

@export var new_record_menu_scene: PackedScene
@export var menu_container: Control

func show_menu(menuType: MenuType):
	var menu: BaseMenu
	match menuType:
		MenuType.NEW_RECORD:
			menu = new_record_menu_scene.instantiate() as BaseMenu
		_:
			printerr('wrong menu type')
	menu_container.add_child(menu)
	menu.show_menu()

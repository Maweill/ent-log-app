extends Control

class_name BaseMenu

var type: Enums.MenuType

@warning_ignore("unused_parameter")
func configure(args: Array = []) -> void:
	pass


func show_menu() -> void:
	print('show menu')


func hide_menu() -> void:
	print('hide menu')
	queue_free()

extends Node

const full_debug := false

func debug(msg: String) -> void:
	if full_debug:
		print_debug(msg)
	else:
		print(msg)

func error(msg: String) -> void:
	printerr(msg)

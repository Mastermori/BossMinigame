class_name State
extends Node

signal request_state_change_to(state_name, msg)
signal request_state_change_back(msg)

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func input(_event: InputEvent) -> void:
	pass

func unhandled_input(_event: InputEvent) -> void:
	pass

func unhandled_key_input(_event: InputEventKey) -> void:
	pass

func notify(_what: int) -> void:
	pass

func change_state_to(state_name: String, msg := {}) -> void:
	emit_signal("request_state_change_to", state_name, msg)

func change_state_back(msg := {}) -> void:
	emit_signal("request_state_change_back", msg)

class_name StateMachine
extends Node

signal transitioned(state_name)

const DEBUG = false

export var initial_state: NodePath

var states := {}
var state: State

var history := []

func _ready() -> void:
	add_states_from_group(self)
	if (initial_state):
		change_to(get_node(initial_state).name)
	elif states.size() > 0:
		change_to(get_child(0).name)
	else:
		printerr("Couldn't find initial state in %s, the state machine has no states" % self.get_path())

func add_states_from_group(group: Node):
	for node in group.get_children():
		if node.is_in_group("state_group"):
			add_states_from_group(node)
		elif node is State:
			states[node.name] = node
		else:
			print("Found none state node in state machine: %s" % node.name)

func enter_state(msg := {}):
	if state:
		state.connect("request_state_change_to", self, "change_to")
		state.connect("request_state_change_back", self, "change_back")
		state.enter(msg)

func exit_state():
	if state:
		state.exit()
		state.disconnect("request_state_change_to", self, "change_to")
		state.disconnect("request_state_change_back", self, "change_back")

func change_to(state_name: String, msg: Dictionary = {}) -> void:
	if not state_name in states.keys:
		return
	
	if DEBUG:
		Console.debug("changing state in %s/%s from %s to %s" % [owner.name, self.name, state.name, state_name])
	
	history.push_back(state.name)
	exit_state()
	state = states[state_name]
	enter_state(msg)
	emit_signal("transitioned", state.name)

func change_back(msg: Dictionary = {}) -> void:
	if history.size() > 0:
		change_to(history.pop_back())


# Delegates for states
func _process(delta):
	if state:
		state.process(delta)

func _physics_process(delta):
	if state:
		state.physics_process(delta)

func _input(event):
	if state:
		state.input(event)

func _unhandled_input(event):
	if state:
		state.unhandled_input(event)

func _unhandled_key_input(event):
	if state:
		state.unhandled_key_input(event)

func _notification(what):
	if state:
		state.notification(what)

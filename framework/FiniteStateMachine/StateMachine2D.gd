extends Node2D

class_name StateMachine2D

const STACK_SIZE = 32

var states_stack : Array[StateInterface2D] = []
var states_map  := {}
var state: StateInterface2D
var queued_states : Array[String] = []
var queued_data : Array[Variant] = []

var initialized := false

signal state_changed(states_stack)
signal state_exited(state)

@export var starting_state: String = ""
@export var host_node: Node
# if you are using both of these, make sure you don't update the 
# AnimatedSprite's current animation with the AnimationPlayer - this will be 
# done automatically if the state name matches the animation name.
@export var animation_players: Array[AnimationPlayer]
@export var animated_sprites: Array[AnimatedSprite2D]

var is_ready = false
var host

func _ready() -> void:
	is_ready = true

func _enter_tree() -> void:
	var custom_host = host_node
	if !is_instance_valid(custom_host):
		host = get_parent()
	else:
		host = custom_host

func init(st: String = "", data=null) -> bool:
	if !is_ready:
		await ready
	if initialized:
		return true

	var can_initialize = false
	var states_array = get_children()
	if states_array == []:
		add_child(StateInterface2D.new())
		states_array = get_children()
	
	if starting_state and st == "":
		st = starting_state
	
	for new_state in states_array:
		if new_state is StateInterface2D:
			states_map[new_state.get_name()] = new_state
			can_initialize = true
			new_state.queue_change.connect(queue_state)
			new_state.queue_change_with_data.connect(queue_state)
			new_state.host = host
			new_state.init()
		else:
			print("Invalid state %s for node %s" % [new_state.get_name(), host.get_name()])
			new_state.queue_free()
			states_array.erase(new_state)
	if !can_initialize:
		queue_free()
		return false

	for animation_player in animation_players:
		if animation_player != null:
			animation_player.animation_finished.connect(auto_transition)

	if st != "":
		_change_state(states_map[st].get_name(), data)
	else:
		_change_state(states_array[0].get_name(), data)
	initialized = true
	return true

func auto_transition(_anim_name) -> void:
	var next = state._animation_finished()
	if next:
		queue_state(next)
	elif state.next_state != "":
		queue_state(state.next_state)

func queue_state(new_state: String, data=null, old_state=state) -> void:
	if old_state.active:
		queued_states = []
		queued_data = []
		queued_states.push_back(new_state)
		queued_data.append(data)
	#if Debug.enabled and queued_data and queued_data[0] != null:
		#Debug.dbg("queued_state_data", queued_data.duplicate(true))

func update(delta: float) -> void:

	var new_state = queued_states.pop_front()
	if new_state:
		var data = queued_data.pop_front()
		_change_state(new_state, data)
	
	if !state.update:
		return

	var next_state_name = state._update_shared(delta)
	if next_state_name == null:
		next_state_name = state._update(delta)
	if next_state_name:
		queue_state(next_state_name)

func tick() -> void:
	if queued_states.size() > 0:
		var state = queued_states.pop_front()
		var data = queued_data.pop_front()
		_change_state(state, data)
	var next_state_name = state._tick_shared()
	if next_state_name == null:
		next_state_name = state._tick()
	if next_state_name == null:
		next_state_name = state._tick_after()
	if next_state_name:
		queue_state(next_state_name)

func deactivate() -> void:
	state.active = false
	state._exit_shared()
	state._exit()
	emit_signal("state_exited", state)

func integrate(st: PhysicsDirectBodyState2D) -> void:
	state._integrate_shared(st)
	state._integrate(st)

func _change_state(state_name: String, data=null) -> void:
	if !(state_name in states_map):
		return
	var next_state: StateInterface2D = states_map[state_name]
	queued_states = []
	queued_data = []

	if state:
		state._exit_shared()
		state._exit()
		emit_signal("state_exited", state)
		state.active = false
		state.set_physics_process(false)
		state.set_process(false)

	state = next_state
	states_stack.push_back(state)
	if states_stack.size() > STACK_SIZE:
		states_stack.pop_front()
	state.active = true
	state.set_physics_process(true)
	state.set_process(true)
#	Debug.dbg("stack size", states_stack.size())
	for animated_sprite in animated_sprites:
		animated_sprite.stop()
		if animated_sprite != null and animated_sprite.sprite_frames != null and animated_sprite.sprite_frames.has_animation(state.animation):
			animated_sprite.frame = 0
			animated_sprite.play.call_deferred(state.animation)
	for animation_player in animation_players:
			if animation_player != null:
				if animation_player.is_playing():
					animation_player.stop()
		#		if animation_player.has_animation("RESET"):
		#			animation_player.play("RESET")
				if animation_player.has_animation(state.animation):
					animation_player.play.call_deferred(state.animation)


	state.data = data
	var new_state = state._enter_shared()
	if new_state:
		_change_state(new_state)
		return
	new_state = state._enter()
	if new_state:
		_change_state(new_state)
		return
	emit_signal("state_changed", states_stack)

func try(method: String, args: Array = []) -> void:
	if state.has_method(method):
		state.callv(method, args)

func last_x_states(x, names=true) -> Array[StateInterface2D]:
	var states = states_stack.slice(-x, states_stack.size())
	if names:
		var s: Array[StateInterface2D] = []
		for state in states:
			s.append(state.name)
		states = s
	states.reverse()
	return states

func get_state(state_name) -> StateInterface2D:
	if states_map.has(state_name):
		return states_map[state_name]
	return null

extends Node
@export_file var start_screen: String
@export_file var start_screen_debug: String

@onready var game_view: GameView = %GameView

func _ready() -> void:
	
	var screen := start_screen
	
	if Debug.enabled:
		screen = start_screen_debug
	
	game_view.load_scene.call_deferred(screen)
	game_view.screen_transition_end(GameView.ScreenTransitionType.Fade)

	get_viewport().gui_focus_changed.connect(_on_focus_changed)

func _on_focus_changed(node: Control) -> void:
	#print(node)
	Debug.dbg("focused", node.name)
	pass

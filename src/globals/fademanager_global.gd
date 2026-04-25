extends Node

enum FadeState {INVISIBLE, FADING, VISIBLE}
var current_fade_state : FadeState
enum FadeType {IN, OUT}

func _ready() -> void:
	pass


func fadeCanvasItem(canvas_item : CanvasItem, method_to_call : Callable, fade_in : float = 1.0, fade_out : float = 1.0, hold : float = 1.0):
	var tween = get_tree().create_tween()
	var finish_callable = Callable(self, "finishFade")
	tween.tween_property(canvas_item, "modulate:a", 1.0, fade_in).from(0.0)
	tween.connect("finished", finish_callable.call(canvas_item, method_to_call, fade_out, hold))


func finishFade(canvas_item : CanvasItem, method_to_call : Callable, fade_out : float = 1.0, hold : float = 1.0):
	var tween = get_tree().create_tween()
	method_to_call.call() # whatever we wanted to run while the screen is hidden
	tween.tween_interval(hold)
	tween.tween_property(canvas_item, "modulate:a", 0.0, fade_out).from(1.0)

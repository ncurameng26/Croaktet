## Grey box stand-in for anything you can pogo off. Flashes when hit.
extends StaticBody2D

@onready var _visual: ColorRect = $ColorRect
var _base_color: Color


func _ready() -> void:
	_base_color = _visual.color


func take_hit(damage: int) -> void:
	print(name, " took ", damage)
	_visual.color = Color.WHITE
	await get_tree().create_timer(0.08).timeout
	_visual.color = _base_color

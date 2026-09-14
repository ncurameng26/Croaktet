## Grey box HUD. Shows which instrument the frog is holding.
extends CanvasLayer

@export var player: Player

@onready var _label: Label = $Label


func _ready() -> void:
	if player == null:
		push_warning("HUD has no player assigned")
		return
	player.instrument_changed.connect(_on_instrument_changed)
	if player.instrument != null:
		_on_instrument_changed(player.instrument)


func _on_instrument_changed(instrument: AttackBase) -> void:
	_label.text = "Instrument: " + instrument.instrument_name

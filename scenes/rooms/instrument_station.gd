## Grey box weapon station. Walk into it to equip the instrument it holds.
## Not consumed, so you can swap back and forth while testing.
extends Area2D

## Path to the instrument script, e.g. res://scripts/instruments/drum_attack.gd.
## Loaded at runtime so a station for a script that does not exist yet
## just warns instead of breaking the scene.
@export_file("*.gd") var instrument_script_path: String
@export var tint := Color.WHITE
@export var label_text := "?"

@onready var _visual: ColorRect = $ColorRect
@onready var _label: Label = $Label


func _ready() -> void:
	_visual.color = tint
	_label.text = label_text
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("equip"):
		return
	var script := load(instrument_script_path) as GDScript
	if script == null:
		push_warning("Station %s: no script at %s" % [name, instrument_script_path])
		return
	# Deferred because we are inside the physics step and equip() edits the tree.
	body.equip.call_deferred(script, tint)

## Base class for every instrument.
##
## An instrument is a Node2D that sits as a child of the Player. It owns the
## pogo hitbox and decides what a hit does. The Player only asks two things:
## "can I pogo right now?" and "what bounce do I get when it lands?"
##
## Subclass this (one file per instrument), set the exported values in
## _init(), and override the _on_* hooks for instrument-specific behaviour.
class_name AttackBase
extends Node2D

## Fired once per swing, the first time the pogo hitbox touches something
## in the "pogoable" group. The Player listens and applies pogo_bounce.
signal pogo_hit(target: Node)

@export var instrument_name := "Instrument"
@export var damage := 1

## Bounce applied to the Player on a hit. y is up (negative). x is applied
## in the Player's facing direction, so +100 means "forward".
@export var pogo_bounce := Vector2(0, -180)

## Hitbox rectangle spawned below the Player during a swing.
@export var pogo_hitbox_size := Vector2(16, 12)
@export var pogo_hitbox_offset := Vector2(0, 16)

## How many physics frames (60/s) the hitbox is live, then locked out.
@export var pogo_active_frames := 6
@export var pogo_recovery_frames := 10

var _hitbox: Area2D
var _shape: CollisionShape2D
var _active_left := 0
var _recovery_left := 0
var _hit_this_swing := false


func _ready() -> void:
	# Build the hitbox in code so every instrument gets one for free.
	# Equivalent to composing a child object in a Java constructor.
	_hitbox = Area2D.new()
	_hitbox.name = "PogoHitbox"
	_hitbox.position = pogo_hitbox_offset
	_hitbox.collision_layer = 0          # the hitbox is never "hit" itself
	_hitbox.collision_mask = 0b101       # sees layers 1 (world) and 3 (enemy)
	_hitbox.body_entered.connect(_on_hitbox_entered)
	_hitbox.area_entered.connect(_on_hitbox_entered)

	var rect := RectangleShape2D.new()
	rect.size = pogo_hitbox_size
	_shape = CollisionShape2D.new()
	_shape.shape = rect
	_shape.disabled = true
	_hitbox.add_child(_shape)
	add_child(_hitbox)


func _physics_process(_delta: float) -> void:
	if _active_left > 0:
		_active_left -= 1
		if _active_left == 0:
			_shape.set_deferred("disabled", true)
			_recovery_left = pogo_recovery_frames
	elif _recovery_left > 0:
		_recovery_left -= 1


func can_pogo() -> bool:
	return _active_left == 0 and _recovery_left == 0


func start_pogo() -> void:
	_hit_this_swing = false
	_active_left = pogo_active_frames
	_shape.set_deferred("disabled", false)
	_on_pogo_started()


func _on_hitbox_entered(target: Node) -> void:
	if _hit_this_swing or not target.is_in_group("pogoable"):
		return
	_hit_this_swing = true
	if target.has_method("take_hit"):
		target.take_hit(damage)
	_on_pogo_hit(target)
	pogo_hit.emit(target)


# ---- Hooks for subclasses. Base versions do nothing. ----

func _on_pogo_started() -> void:
	pass


func _on_pogo_hit(_target: Node) -> void:
	pass

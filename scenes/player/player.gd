## The frog. Run, variable-height jump, and pogo via the equipped instrument.
## All numbers come from Frog Band/Movement.md and are @export so they can be
## tuned in the Inspector while the game runs.
class_name Player
extends CharacterBody2D

@export var run_speed := 120.0
@export var jump_velocity := -260.0
@export var gravity_rise := 900.0
@export var gravity_fall := 1100.0
@export var max_fall_speed := 400.0
@export var jump_cut_mult := 0.4
@export var coyote_time := 0.1
@export var jump_buffer_time := 0.1

## The equipped instrument. Swapping instruments later means swapping this node.
@onready var instrument: AttackBase = $Instrument

var facing := 1.0          # 1 = right, -1 = left
var _coyote_left := 0.0
var _buffer_left := 0.0
var _can_cut_jump := false  # true after a jump, false after a pogo bounce


func _ready() -> void:
	instrument.pogo_hit.connect(_on_pogo_hit)


func _physics_process(delta: float) -> void:
	var on_floor := is_on_floor()

	# --- Timers (coyote and jump buffer) ---
	if on_floor:
		_coyote_left = coyote_time
	else:
		_coyote_left = maxf(_coyote_left - delta, 0.0)

	if Input.is_action_just_pressed("jump"):
		_buffer_left = jump_buffer_time
	else:
		_buffer_left = maxf(_buffer_left - delta, 0.0)

	# --- Horizontal: instant, no acceleration ---
	var dir := Input.get_axis("move_left", "move_right")
	velocity.x = dir * run_speed
	if dir != 0.0:
		facing = signf(dir)
		instrument.scale.x = facing   # mirrors the hitbox offset for forward pogos

	# --- Gravity: heavier on the way down for the Hollow Knight apex ---
	if not on_floor:
		var g := gravity_rise if velocity.y < 0.0 else gravity_fall
		velocity.y = minf(velocity.y + g * delta, max_fall_speed)

	# --- Jump ---
	if _buffer_left > 0.0 and _coyote_left > 0.0:
		velocity.y = jump_velocity
		_buffer_left = 0.0
		_coyote_left = 0.0
		_can_cut_jump = true

	if _can_cut_jump and velocity.y < 0.0 and Input.is_action_just_released("jump"):
		velocity.y *= jump_cut_mult
		_can_cut_jump = false

	# --- Pogo: Down + Attack, airborne only ---
	if not on_floor \
			and Input.is_action_pressed("move_down") \
			and Input.is_action_just_pressed("attack") \
			and instrument.can_pogo():
		instrument.start_pogo()

	move_and_slide()


func _on_pogo_hit(_target: Node) -> void:
	var b: Vector2 = instrument.pogo_bounce
	velocity.y = b.y
	if b.x != 0.0:
		velocity.x = b.x * facing
	_can_cut_jump = false

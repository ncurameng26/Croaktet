## Bass: vault. Slow wide sweep that hits groups, medium bounce, carries the
## frog forward in the facing direction.
##
## The forward push is the x component of pogo_bounce. Whether it survives
## past the first frame depends on how the Player handles horizontal velocity
## after a bounce; see the momentum note in Movement.md.
class_name BassAttack
extends AttackBase


func _init() -> void:
	instrument_name = "Bass"
	damage = 1
	pogo_bounce = Vector2(100, -230)
	# Wide and shallow: a sweep, not a stab.
	pogo_hitbox_size = Vector2(40, 10)
	pogo_hitbox_offset = Vector2(0, 16)
	pogo_active_frames = 12
	pogo_recovery_frames = 24


func _on_pogo_hit(target: Node) -> void:
	print("Bass hit ", target.name)

## Trumpet: recoil launch. Ranged blast downward, highest bounce, straight up.
##
## "Ranged" is a tall hitbox that reaches several tiles below the frog rather
## than a projectile. Good enough for the grey box; swap for a projectile later
## if the feel is wrong. Max range is an open question in Movement.md.
class_name TrumpetAttack
extends AttackBase


func _init() -> void:
	instrument_name = "Trumpet"
	damage = 1
	pogo_bounce = Vector2(0, -300)
	# 3 tiles tall, centred 2 tiles below the frog's feet.
	pogo_hitbox_size = Vector2(10, 48)
	pogo_hitbox_offset = Vector2(0, 40)
	pogo_active_frames = 8
	pogo_recovery_frames = 18


func _on_pogo_hit(target: Node) -> void:
	print("Trumpet hit ", target.name)

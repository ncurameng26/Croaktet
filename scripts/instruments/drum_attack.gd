## Drum: ground pound. Single heavy hit, heavy stagger, low straight-up bounce.
## Shockwave on landing is not built yet (see Movement.md).
class_name DrumAttack
extends AttackBase


func _init() -> void:
	instrument_name = "Drum"
	damage = 2
	pogo_bounce = Vector2(0, -180)
	pogo_hitbox_size = Vector2(18, 10)
	pogo_active_frames = 6
	pogo_recovery_frames = 12


func _on_pogo_hit(target: Node) -> void:
	print("Drum hit ", target.name)

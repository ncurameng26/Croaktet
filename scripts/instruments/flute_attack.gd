## Flute: Fast weak hit, tiny bounce, keeps your horizontal momentum so you can chain across a line of enemies
class_name FluteAttack
extends AttackBase


func _init() -> void:
	instrument_name = "Flute"
	damage = 1
	pogo_bounce = Vector2(0, -150)
	pogo_hitbox_size = Vector2(10, 70)
	pogo_active_frames = 6
	pogo_recovery_frames = 6


func _on_pogo_hit(target: Node) -> void:
	print("Flute hit ", target.name)
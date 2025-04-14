extends Monster

func move(delta: float) -> void:
	super.move(delta)
	look_at(player.global_position)
	$Sprite2D.flip_h = true

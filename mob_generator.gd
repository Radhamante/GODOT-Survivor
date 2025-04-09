extends Node

const BAT = preload("res://characters/monsters/bat/scene/bat.tscn")
const SLIME = preload("res://characters/monsters/slime/scene/slime.tscn")

const mobs = [
	BAT,SLIME
]

func spawn_mod():
	var new_mod = mobs.pick_random().instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	
	new_mod.global_position = %PathFollow2D.global_position
	
	add_child(new_mod)

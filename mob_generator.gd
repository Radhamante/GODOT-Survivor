extends Node

const BAT = preload("res://characters/monsters/bat/scene/bat.tscn")
const SLIME = preload("res://characters/monsters/slime/scene/slime.tscn")
const SNAKE = preload("res://characters/monsters/snake/scene/snake.tscn")
const SNAIL = preload("res://characters/monsters/snail/scene/snail.tscn")
const SPIDER = preload("res://characters/monsters/spider/scene/spider.tscn")
const GHOST = preload("res://characters/monsters/ghost/scene/ghost.tscn")
const SAUSAGE = preload("res://characters/monsters/sausage/scene/sausage.tscn")

const mobs = [
	BAT,SLIME, SNAKE, SNAIL, SPIDER, GHOST, SAUSAGE
]

func spawn_mod():
	var new_mod = mobs.pick_random().instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	
	new_mod.global_position = %PathFollow2D.global_position
	
	add_child(new_mod)

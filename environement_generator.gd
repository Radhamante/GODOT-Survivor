extends Node2D

const GREEN_TREE = preload("res://trees/scenes/green-tree.tscn")
const BIG_MOSSY_ROCK = preload("res://trees/scenes/big_mossy_rock.tscn")
const BUSH = preload("res://trees/scenes/bush.tscn")
const MOSSY_ROCK = preload("res://trees/scenes/mossy_rock.tscn")
const ORANGE_TREE = preload("res://trees/scenes/orange-tree.tscn")

var spawn_timer : float = 0.0  # Internal timer for delay between shots
@export var spawn_delay : float = 1 
var try_to_spawn = false

var foliages: Array[PackedScene] = [GREEN_TREE, BIG_MOSSY_ROCK,BUSH,MOSSY_ROCK,ORANGE_TREE,]

func _process(delta: float) -> void:
	spawn_timer += delta

	# Check if we can spawn (timer has reached shotspeed)
	if spawn_timer >= spawn_delay or try_to_spawn:
		try_to_spawn = !try_to_spawn
		spawn_timer = 0
		if try_to_spawn:
			spawn_foliage()
		else:
			move_test_area()

func move_test_area():
	%PathFollow2D.progress_ratio = randf()
	%CanSpawn.global_position = %PathFollow2D.global_position

func spawn_foliage():
	var overlapping_bodies = %CanSpawn.get_overlapping_bodies()

	# Si aucun chevauchement n'est détecté, ajoutez le feuillage
	if overlapping_bodies.size() == 0:
		var new_foliage: StaticBody2D = foliages[randi() % foliages.size()].instantiate()
		new_foliage.global_position = %CanSpawn.global_position
		new_foliage.scale = Vector2.ONE * (1 + randf())
		add_child(new_foliage)

extends Node

const GREEN_TREE = preload("res://trees/scenes/green-tree.tscn")
const BIG_MOSSY_ROCK = preload("res://trees/scenes/big_mossy_rock.tscn")
const BUSH = preload("res://trees/scenes/bush.tscn")
const MOSSY_ROCK = preload("res://trees/scenes/mossy_rock.tscn")
const ORANGE_TREE = preload("res://trees/scenes/orange-tree.tscn")

var foliages: Array[PackedScene] = [GREEN_TREE, BIG_MOSSY_ROCK,BUSH,MOSSY_ROCK,ORANGE_TREE,]

func spawn_foliage():
	var new_foliage: StaticBody2D = foliages[randi() % foliages.size()].instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_foliage.scale = Vector2.ONE * (1 + randf())
	new_foliage.global_position = %PathFollow2D.global_position
	
	add_child(new_foliage)

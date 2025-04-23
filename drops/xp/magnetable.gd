extends Node2D
class_name Magnetable

var entity: Node2D
var speed: float = 800

func magnet_to(_entity: Node2D):
	entity = _entity

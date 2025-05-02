extends Resource
class_name CharacterInfo

@export var character_name: String
@export var description: String
@export var logo: Resource
@export var appearance: Resource
@export var health: float
@export var max_health: float
@export var speed: float
@export var armor: float
@export var weapons: Array[PackedScene]
@export var xp: float
@export var level: int
@export var xp_by_level_multipler: float
@export var upgrade_by_level: int = 3
@export var max_weapons: int = 5

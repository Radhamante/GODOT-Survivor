extends Resource
class_name LevelInfo

@export var logo: CompressedTexture2D
@export var name: String
@export var description: String
@export_range(1, 5, 1) var dificulty: int
@export var difficulty_levels : DifficultyLevels
@export var background: CompressedTexture2D
@export var music: AudioStream

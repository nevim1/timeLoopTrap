extends Area2D
signal player_detection
@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready() -> void:
	player_detection.connect(level.player_detection)
	
func _on_body_entered(_body):
	player_detection.emit(true)


func _on_body_exited(_body):
	player_detection.emit(false)

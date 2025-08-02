extends Area2D
signal box_detection
@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready() -> void:
	box_detection.connect(level.box_detection)

func _on_body_entered(body):
	box_detection.emit(true)
	


func _on_body_exited(body):
	box_detection.emit(false)

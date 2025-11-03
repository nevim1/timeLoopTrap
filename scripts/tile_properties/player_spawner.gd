extends Module

@onready var level : Node2D = get_tree().get_root().get_node('level')
@onready var tile_set : TileMapLayer = level.get_node('BGTileMapLayer')
@onready var animation_player : AnimatedSprite2D = get_node("../AnimatedSprite2D")
@onready var ray_cast_2d : RayCast2D = get_node("../BoxRaycast") 

var player_scene : PackedScene = preload('res://scenes/tiles/Player.tscn')


func _ready():
	animation_player.play("default_1")
	level.end_loop.connect(end_loop)

func end_loop():
	var new_player = player_scene.instantiate()
	new_player.position = get_parent().position + Vector2(32,0)
	tile_set.add_child(new_player)

using Godot;
using System;

public partial class Player : CharacterBody2D {
	[Export]
	public int gridSize {get; set;} = 32;
	private RayCast2D raycast;

	public override void _Ready(){
		raycast = GetNode<RayCast2D>("RayCast2D");
	}

	public override void _Input(InputEvent @event){
		if Input.isActionPressed("moveUp"){
			private Vector2D direction = gridSize * Vector2D.UP;
			raycast.ForceRaycastUpdate();
			if(!raycast.IsColliding()){
				Position += direction;
			}
		}
	}
}

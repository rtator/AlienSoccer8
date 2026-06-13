extends RigidBody2D

var speed = 2000
 
@export var authority_pos := Vector2(0,0)

func _physics_process(delta):
	if is_multiplayer_authority():
		var input = Input.get_vector("p1_left","p1_right","p1_up","p1_down")
		
		linear_velocity += input * speed * delta
#
func _ready():
	set_multiplayer_authority(int(name))
	%CollisionShape2D.set_multiplayer_authority(int(name))
	%Basic.set_multiplayer_authority(int(name))
	%MultiplayerSynchronizer.set_multiplayer_authority(int(name))

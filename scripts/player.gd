extends CharacterBody2D

signal health_depleted

var health = 100.0 

func _physics_process(_delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		get_node("HappyBoo").play_walk_animation()
	else:
		get_node("HappyBoo").play_idle_animation()
		
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %Hurtbox.get_overlapping_bodies()
	if  overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * _delta
		%ProgressBar.value = health
		%ProgressBar.max_value = 500
		if health <= 0.0:
			health_depleted.emit()
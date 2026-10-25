image_alpha = global.escape.active ? 1 : 0.5

if place_meeting(x, y, obj_player) && cutscene == false && canEnter && !global.time_attack_started
{
	if global.escape.active
	{
		// Normal lap 2 behavior
		ds_list_add(global.saveroom, id)
		cutscene = true
		global.collect += 3000
		with obj_player
		{
			targetRoom = other.targetRoom
			door = other.targetDoor
			state = -4
			sprite_index = spr_player_spinout
			image_speed = 0.35
		}
		sprite_index = spr_partydooropen
		image_index = 0
	}
	else if global.level == "forest"
	{
		// Entering a party portal outside of escape starts Time Attack
		ds_list_add(global.saveroom, id)
		cutscene = true
		global.time_attack = true
		global.time_attack_started = true
		global.time_attack_timer = 0
		global.time_attack_arrival = true
		with obj_player
		{
			targetRoom = global.resetRoom
			door = "A"
			state = -4
			sprite_index = spr_player_spinout
			image_speed = 0.35
		}
		sprite_index = spr_partydooropen
		image_index = 0
	}
}
if cutscene = true
{
	with obj_player
	{
		state = -4
		vsp = 0
		hsp = 0
		x = approach(x, other.x, 3)
		y = approach(y, other.y, 3)
		xscaleMulti = approach(xscaleMulti, 0, 0.05)
		yscaleMulti = approach(yscaleMulti, 0, 0.05)
		movespeed = 0
	}
	if animation_end() && sprite_index == spr_partydooropen
	{
		image_index = image_number - 1
		if !instance_exists(obj_fadeout)
			instance_create(x, y, obj_fadeout)
		ds_list_clear(global.escaperoom)
	}
	
}

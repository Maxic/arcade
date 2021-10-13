extends Node2D

var charge_color

func update_colors(latest_color):
	$indicator_3.set_color($indicator_2.current_color)
	$indicator_2.set_color($indicator_1.current_color)
	$indicator_1.set_color(latest_color)
	
#if all gems are the same color, activate the charge in that color
	if $indicator_1.current_color == $indicator_2.current_color && $indicator_1.current_color == $indicator_3.current_color:
		charge_color = $indicator_1.current_color
	else:
		charge_color = "empty"
	get_parent().set_charge(charge_color)
			

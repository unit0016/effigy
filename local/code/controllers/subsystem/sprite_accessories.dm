/datum/controller/subsystem/accessories
	var/list/sprite_accessory_layers = list()

/datum/controller/subsystem/accessories/proc/get_sprite_accessory_layers(icon_file)
	if(sprite_accessory_layers[icon_file])
		return sprite_accessory_layers[icon_file]
	else
		var/json_list = rustg_dmi_icon_states(icon_file)
		var/list/decoded_list = json_decode(json_list)
		sprite_accessory_layers[icon_file] = LAZYCOPY(decoded_list)
		return sprite_accessory_layers[icon_file]

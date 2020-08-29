extends Node2D

func spawn_entity(packed_scene_path, entity_properties, parent):
	rpc("_spawn_entity", packed_scene_path, entity_properties, parent)

remotesync func _spawn_entity(packed_scene_path, entity_properties, parent):
	var ent = load(packed_scene_path).instance()
	for key in entity_properties:
		ent.call("set", key, entity_properties[key])
	ent.set_network_master(entity_properties["pid"])
	if parent == null:
		parent = get_tree().get_root()
	parent.call_deferred("add_child", ent)

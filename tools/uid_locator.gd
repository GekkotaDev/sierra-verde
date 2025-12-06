@tool extends EditorScript


var uid_string = "uid://y122bejj8li3"


func _run():
	var uid = ResourceUID.text_to_id(uid_string)
	var path = ResourceUID.get_id_path(uid)
	print_debug("{uid} path: {path}".format({
		"uid": uid_string,
		"path": path,
	}))

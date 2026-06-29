extends Node

func add_log_msg(msg: String):
	var console = get_tree().get_first_node_in_group("debug_console")
	if console:
		var log_lable = console.find_child("logsLables")
		if log_lable:
			log_lable.text += msg +"\n"

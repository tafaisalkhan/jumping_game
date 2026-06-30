extends Control

@onready var topbar = $topbar
@onready var topbar_bg = $topbarBG
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var os_name = OS.get_name()
	if os_name == "Android" || os_name =="iOS":
		var safe_area = DisplayServer.get_display_safe_area()
		var safe_area_top = safe_area.position.y 
		
		if os_name == "iOS":
			var screen_scale = DisplayServer.screen_get_scale()
			safe_area_top = (safe_area_top / screen_scale)

		topbar.position.y += safe_area_top
		var margrin = 10
		topbar_bg.size.y += safe_area_top + margrin



func _on_pause_btn_pressed() -> void:
	pass # Replace with function body.

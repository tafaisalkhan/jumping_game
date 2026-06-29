extends TextureButton
class_name ScreenButton
signal clicked(buuton)


func _on_pressed() -> void:
	clicked.emit(self) # Replace with function body.

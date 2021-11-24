extends Spatial

func _ready():
	vr.initialize();

func _process(delta):
	$OQ_ARVROrigin/OQ_RightController/Feature_UIRayCast.ui_raycast_mesh.visible = true


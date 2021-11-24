extends Spatial



var labeltext = "unknown"

func processlocalavatarposition(delta):
	transform = vr.vrOrigin.transform
	$HeadCam.transform = vr.vrCamera.transform
	$HandLeft.transform = vr.leftController.transform
	$HandRight.transform = vr.rightController.transform


func avatartoframedata():
	var fd = {  NCONSTANTS2.CFI_VRORIGIN_POSITION: transform.origin, 
				NCONSTANTS2.CFI_VRORIGIN_ROTATION: transform.basis.get_rotation_quat(), 
				NCONSTANTS2.CFI_VRHEAD_POSITION: $HeadCam.transform.origin, 
				NCONSTANTS2.CFI_VRHEAD_ROTATION: $HeadCam.transform.basis.get_rotation_quat(), 
				NCONSTANTS2.CFI_VRHANDLEFT_POSITION: $HandLeft.transform.origin, 
				NCONSTANTS2.CFI_VRHANDLEFT_ROTATION: $HandLeft.transform.basis.get_rotation_quat(), 
				NCONSTANTS2.CFI_VRHANDRIGHT_POSITION: $HandRight.transform.origin, 
				NCONSTANTS2.CFI_VRHANDRIGHT_ROTATION: $HandRight.transform.basis.get_rotation_quat()
			 }
	return fd

func framedatatoavatar(fd):
	transform = Transform(Basis(fd[NCONSTANTS2.CFI_VRORIGIN_ROTATION]), fd[NCONSTANTS2.CFI_VRORIGIN_POSITION])
	$HeadCam.transform = Transform(Basis(fd[NCONSTANTS2.CFI_VRHEAD_ROTATION]), fd[NCONSTANTS2.CFI_VRHEAD_POSITION])
	$HandLeft.transform = Transform(Basis(fd[NCONSTANTS2.CFI_VRHANDLEFT_ROTATION]), fd[NCONSTANTS2.CFI_VRHANDLEFT_POSITION])
	$HandRight.transform = Transform(Basis(fd[NCONSTANTS2.CFI_VRHANDRIGHT_ROTATION]), fd[NCONSTANTS2.CFI_VRHANDRIGHT_POSITION])

func initavatar(avatardata, firstlocalinit):
	if firstlocalinit:
		pass
	labeltext = avatardata["labeltext"]

func avatarinitdata():
	var avatardata = { "avatarsceneresource":filename, 
					   "labeltext":labeltext
					 }
	return avatardata
	
static func changethinnedframedatafordoppelganger(fd, doppelnetoffset):
	fd[NCONSTANTS.CFI_TIMESTAMP] += doppelnetoffset
	fd[NCONSTANTS.CFI_TIMESTAMPPREV] += doppelnetoffset
	if fd.has(NCONSTANTS2.CFI_VRORIGIN_POSITION):
		fd[NCONSTANTS2.CFI_VRORIGIN_POSITION].z += -2
	if fd.has(NCONSTANTS2.CFI_VRORIGIN_ROTATION):
		fd[NCONSTANTS2.CFI_VRORIGIN_ROTATION] *= Quat(Vector3(0, 1, 0), deg2rad(180))

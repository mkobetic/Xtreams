read, write, position
position: pos
	"Set the receiver's file position."

	^ self primSetPosition: self handle to: pos
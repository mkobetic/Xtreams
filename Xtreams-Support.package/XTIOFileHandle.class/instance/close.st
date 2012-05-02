open/close
close
	"Close this file."

	self closed ifFalse: [ self primClose: self handle ]

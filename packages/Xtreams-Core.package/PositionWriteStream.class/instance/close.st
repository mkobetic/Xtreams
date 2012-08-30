initialize-release
close
	super close.
	buffer recycle.
	buffer := nil
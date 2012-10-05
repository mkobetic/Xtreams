initialize-release
close
	active == nil ifFalse: [active close].
	super close
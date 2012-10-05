initialize-release
initialize
	self makeNonviewableInstances.
	Smalltalk addToShutDownList: self after: DisplayScreen
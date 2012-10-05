initialize-release
close
	"Close the destination from any more writes."

	self flush.
	destination close
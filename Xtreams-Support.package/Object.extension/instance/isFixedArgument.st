*Xtreams-Support
isFixedArgument
	"Answer if the receiver, when passed as an argument through the 
	 DLL & C Connect, represents data at a fixed address.  This is true
	 for objects created via the newInFixedSpace: primitive. Fail if the
	 receiver is immediate, since it has no data.  In this case the Smalltalk
	 code copes with the immediate case."

	^false
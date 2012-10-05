Abstract superclass of all read streams, defines the API.

Read streams are created by sending #reading to a concrete resource (a.k.a terminal), such as a Collection, SocketAccessor, Filename, etc.

	'testing' reading rest

Transform read streams are created through one of the messages in the 'transforming' protocol sent to other read streams.

	('testing' reading collecting: #asUppercase) rest

Subclasses must implement the following messages:
	#read:into:at:
	#contentsSpecies

Instance Variables
	source	<Object> a read stream or "terminal" producing the elements


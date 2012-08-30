Abstract superclass of all write streams; defines the API.

Write streams are created by sending #writing to a concrete resource (a.k.a terminal), such as a Collection, SocketAccessor, Filename, etc.

	String new writing write: 'testing'; close; terminal

Transform write streams are created through one of the messages in the 'transforming' protocol sent to other write streams.

	(String new writing collecting: #asUppercase) write: 'testing'; close; terminal

Subclasses must implement the following messages:
	#read:into:at:
	#contentsSpecies

Instance Variables
	destination	<Object> a stream or "terminal" consuming written elements

Shared Variables
	Backspace	<Character>
	Bell	<Character>
	CarriageReturn	<Character>
	Delete	<Character>
	DoubleQuote	<Character>
	Escape	<Character>
	FormFeed	<Character>
	LineFeed	<Character>
	Quote	<Character>
	Space	<Character>
	Tab	<Character>
	VerticalTab	<Character>


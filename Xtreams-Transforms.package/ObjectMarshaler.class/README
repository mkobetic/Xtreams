Marshaler defines the binary format for various object types it is meant to support. This one defines generic marshaling format for arbitrary Smaltalk objects, named STST 2.0. It is used as the default marshaler for marshaling streams. It is designed to be reasonably compact and fast to marshal / unmarshal. Objects have no persistent identity between transactions, but do within a transaction to allow for recursion.

Record Format:
	<class record> <object record>

Class Format:
	Class name is only included if this is the first reference to a class id that isn't known by the terminals.
	<class id : integer> (<class absoluteName : string> <class isMeta : 0 = false, 1 = true>)?

Object Format:
	Object id is not included if the object is an immediate, in which case the object body is always included.
	Object body is not included if the object is has previously been shared between the terminals in this transaction.
	<object id : integer>? <object body>?		

Object Body Formats:
	integers:
		0 .. 252											one byte
		-2147483647 .. 2147483648						four bytes
		-9223372036854775807 .. 9223372036854775808	eight bytes
		larger integers									a stringified base 36 number
		float												four bytes
		double											eight bytes

	true / false / nil:
		No space beyond the record entry

	class:
		A repeat of the Class Format

	characters:
		<character : integer>

	strings:
		<string size : integer> <characters : character>*

	bytes:
		<byte array size: integer> <bytes : one byte>*

	collection:
		<collection size : integer> <elements : record>*

	dictionary / keyed collection:
		<dictionary size : integer> (<key : record> <value : record>)*

	object:
		The basicSize is only included if the object class isVariable
		<basicSize : integer>? <instance variables : record)* (basic variables : record)*

Example Records:
	true:		21 (true)
	128:		19 (SmallInteger) 128
	'test':		4 (ByteString) 1 (object id) 4 (string length) 116 $t 101 $e 115 $s 116 $t
	5 asValue:
		23 (ValueHolder) 29 (class name length) ...29.. ('Root.Smalltalk.UI.ValueHolder') 0 (not meta) 1 (object id)
			22 (nil)
			19 (SmallInteger) 5
	(5 @ 6):
		18 (Point) 1 (object id)
			19 (SmallInteger) 5
			19 (SmallInteger) 6
	(Array with: 5 asValue with: 5 asValue):
		1 (Array) 1 (object id) 2 (array length)
			23 (ValueHolder) 29 (class name length) ...29.. ('Root.Smalltalk.UI.ValueHolder') 0 (not meta) 2 (object id)
				22 (nil)
				19 (SmallInteger) 5
			23 (ValueHolder) 3 (object id)
				22 (nil)
				19 (SmallInteger) 5

Instance Variables
	classes	<Array of: Class> maps class IDs to classes
	read	<Dictionary key: Class value: Symbol> maps classes to methods to use to unmarshal
	write	<Dictionary key: Class value: Symbol> maps classes to methods to use to marshal
	version	<ByteArray> version id, e.g. (STST 2.0)
	rehash	<Array of: Class> list of classes that need to be rehashed after unmarshaling
	analyse	<Array of: Symbol> maps class IDs to corresponding analysing method selector
	immediate	<Array of: Boolean> maps class IDs to value of #hasImmediateInstances for that class


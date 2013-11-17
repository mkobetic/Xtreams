"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: substreaming
"
, aReadStream
	"Return a read stream that combines self and @aReadStream into a single stream.
	""
		((1 to: 5) reading, (6 to: 10) reading) rest
	""
		| files |
		files := '/pub/vw7.8' asFilename reading.
		[ | fn | fn := files get. fn isDirectory ifTrue: [ files := fn reading, files ]. fn ] reading rest
	"
	^(Array with: self with: aReadStream) reading stitching

"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: substreaming
"
stitching
	"From a stream that returns streams (either read or write streams), stitch them together sequencially such that they appear to be one contiguous stream."
	"^ <StitchReadStream>"
	"
		| data current |
		data := (1 to: 100) reading.
		current := nil.
		[       (current notNil and: [ current position < 10 ]) ifTrue: [ Incomplete zero raise ].
			current := data limiting: 10
		] reading stitching rest
	"
	| first |
	first := self get.
	first isReadable ifTrue: [^StitchReadStream on: self first: first].
	first isWritable ifTrue: [^StitchWriteStream on: self first: first].
	^self error: 'Cannot read or write to this stream, what is it?'

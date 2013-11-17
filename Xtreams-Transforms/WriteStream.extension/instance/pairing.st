"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: transforming
"
pairing
	"Transform a stream of elements in to a stream of associations between even+odd elements of the stream. This expects the stream to have an even number of elements"

	^self transforming: [:in :out | out put: (Association key: in get value: in get)]

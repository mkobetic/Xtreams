"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: transforming
"
depairing
	"Transform a stream of associations in to a stream of elements made up of the key and value association components."

	^self transforming: [:in :out |
		| association |
		association := in get.
		out put: association key.
		out put: association value]

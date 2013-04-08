"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
depairing
	"Transform a stream of associations in to a stream of elements made up of the key and value association components."

	^self transforming: [:in :out |
		| association |
		association := in get.
		out put: association key.
		out put: association value]
as yet unclassified
printWith: aBlock
	| printer stream |
	printer := XTNumberPrinter new.
	stream := String new writing.
	aBlock value: printer value: stream.
	^ stream conclusion.
	
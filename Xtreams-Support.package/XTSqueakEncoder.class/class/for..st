instance creation
for: anEncoding

	| encoder |
	encoder := ZnCharacterEncoder newForEncoding: anEncoding.
	^self new encoder: encoder
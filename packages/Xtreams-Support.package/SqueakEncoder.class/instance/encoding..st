accessing
encoding: anEncoding

	encoder := (TextConverterMap at: anEncoding) new.
	(encoder isKindOf: UTF16TextConverter) ifTrue: [ encoder useLittleEndian: false ]
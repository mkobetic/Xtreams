accessing
getDigestByName: id

	| hash |
	self digestsLoaded ifFalse: [
		self OpenSSLAddAllDigests.
		self digestsLoaded: true ].
	hash := self EVPGetDigestbyname: id.
	hash getHandle asInteger isZero ifTrue: [ self error: 'Unknow digest ', id ].
	^hash
instance creation
new
	
	^Smalltalk os platformName = 'Win32'
		ifTrue: [XTBCryptHash basicNew initialize]
		ifFalse: [XTLibCryptoHash basicNew initialize]

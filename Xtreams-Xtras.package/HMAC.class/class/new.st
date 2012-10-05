instance creation
new
	
	^Smalltalk os platformName = 'Win32'
		ifTrue: [XTBCryptHash basicNew initialize]
		ifFalse: [XTLibCryptoHMAC basicNew initialize]
accessing
version: version tokensInto: block
"Takes apart the @version <Integer> and invokes @block with up to 5 arguments corresponding to individual components of the version identifier describe below. Returns the result of @block.
	major - major version number (currently 0)
	minor - minor version number (currently usually 9)
	fix - the third component of the version (e.g. 8 for 0.9.8)
	patch - number corresponding to the patch level letter: 0=no patch level, 1=a, 2=b, 3=c,... (e.g. 2 for 0.9.8b)
	status - 0-15; 0=dev, 1-14=beta 1-14, 15=release

Relevant notes from: http://openssl.org/docs/crypto/OPENSSL_VERSION_NUMBER.html 

OPENSSL_VERSION_NUMBER is a numeric release version identifier:
	MMNNFFPPS: major minor fix patch status
The status nibble has one of the values 0 for development, 1 to e for betas 1 to 14, and f for release. for example
	 0x000906000 == 0.9.6 dev
	 0x000906023 == 0.9.6b beta 3
	 0x00090605f == 0.9.6e release
Versions prior to 0.9.3 have identifiers < 0x0930. Versions between 0.9.3 and 0.9.5 had a version identifier with this interpretation:
	MMNNFFRBB major minor fix final beta/patch
for example
	0x000904100 == 0.9.4 release
	0x000905000 == 0.9.5 dev
Version 0.9.5a had an interim interpretation that is like the current one, except the patch level got the highest bit set, to keep continuity. The number was therefore 0x0090581f.

Samples:
	self versionStringFrom: 16r906000
	self versionStringFrom: 16r906023
	self versionStringFrom: 16r90605f
	self versionStringFrom: 16r904100
	self versionStringFrom: 16r905000
	self versionStringFrom: 16r90581f
	self versionStringFrom: self xif SSLeay
"
	| tokens arguments |
	version < 16r930 ifTrue: [ self error: 'Cannot interpret versions prior to OpenSSL 0.9.3' ].
	tokens := (ByteArray new: 5) writeStream.
	"major"	tokens nextPut: (version bitShift: -28).
	"minor"	tokens nextPut: ((version bitShift: -20) bitAnd: 255).
	"fix"		tokens nextPut: ((version bitShift: -12) bitAnd: 255).
	version < 16r905020
		ifTrue: [ | final number | 
			"I don't want to change the meaning of the block parameters for the pre-0.9.5a versions, so let's try to reinterpret them in post-0.9.5 terms.
			This only concerns versions 0.9.3 to 0.9.5 which should be less and less relevant anyway"
			final := (version bitShift: -8) bitAnd: 15.
			number := version bitAnd: 255.
			final = 1
				ifTrue: [ tokens nextPut: number "patch"; nextPut: 15 "release" ]
				ifFalse: [ tokens nextPut: 0 "patch"; nextPut: number "dev/beta" ]	]
		ifFalse: [ version = 16r905100 "0.9.5 release happens to fall into this range"
				ifTrue: [ tokens nextPutAll: #[0 15] "0.9.5 release" ]
				ifFalse: [
					"patch" 	tokens nextPut: ((version bitShift: -4) bitAnd: 16r7F "because 0.9.5a had the hi-bit set").
					"status" 	tokens nextPut: (version bitAnd: 15) ] ].
	arguments := tokens contents asArray copyFrom: 1 to: block numArgs.
	^block valueWithArguments: arguments
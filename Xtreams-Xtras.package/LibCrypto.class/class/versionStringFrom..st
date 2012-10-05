accessing
versionStringFrom: version
"Convert @version <Integer> into a version string (e.g. '0.9.8b beta 4').
	self versionStringFrom: self xif SSLeay
"
	^self version: version tokensInto: [ :major :minor :fix :patch :status || string |
		string := String new writeStream.
		string print: major; nextPut: $.;
			print: minor; nextPut: $.;
			print: fix.
		patch = 0 ifFalse: [
			string nextPut: ($a asInteger - 1 + patch) asCharacter ].
		string space; nextPutAll: (
			status = 0
				ifTrue: [ 'dev' ]
				ifFalse: [ status = 15
					ifTrue: [ 'release' ]
					ifFalse: [ 'beta <1p>' expandMacrosWith: status ] ] ).
		string contents ]
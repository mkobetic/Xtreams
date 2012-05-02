accessing
versionTokensInto: block
"Invoke the @block with individual parts of the version of the shared library that we're using right now.
For example to check that we're running at least 0.9.7:
	self versionTokensInto: [ :major :minor :fix | ((((major bitShift: 8) bitOr: minor) bitShift: 8) bitOr: fix) >= 16r000907 ]
To check that we're using only an official release (no dev or beta):
	self versionTokensInto: [ :major :minor :fix :patch :status | status = 15 ]
"
	^self version: self SSLeay tokensInto: block
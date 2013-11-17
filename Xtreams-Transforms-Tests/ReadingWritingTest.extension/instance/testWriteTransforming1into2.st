"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testWriteTransforming1into2
	| result |
	(self output transforming: [:in :out | | x | x := in get. out put: x; put: x])
		write: #[ 1 2 3 ];
		close.
	result := (self input read: 6).
	self assert: result = #[ 1 1 2 2 3 3 ]

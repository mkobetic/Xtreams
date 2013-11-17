"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testReadIntoAtPastEnd
	| result |

	self output write: #[ 1 2 3 4 ]; close.
	self input read: 1.
	result := ByteArray new: 4 withAll: 255.
	self assert: ([self input read: 4 into: result at: 1. false] on: Incomplete do: [ :eos | eos count = 3 ]).
	self assert: result = #[2 3 4 255]

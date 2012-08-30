queries
statusString
	"Return a string describing the status of this socket."

	| status |
	status := self connectionStatus.
	status == InvalidSocket ifTrue: [^ 'invalidSocketHandle'].
	status == Unconnected ifTrue: [^ 'unconnected'].
	status == WaitingForConnection ifTrue: [^ 'waitingForConnection'].
	status == Connected ifTrue: [^ 'connected'].
	status == OtherEndClosed ifTrue: [^ 'otherEndClosedButNotThisEnd'].
	status == ThisEndClosed ifTrue: [^ 'thisEndClosedButNotOtherEnd'].
	self isDestroyed ifTrue: [^ 'destroyed'].
	^ 'unknown socket status'

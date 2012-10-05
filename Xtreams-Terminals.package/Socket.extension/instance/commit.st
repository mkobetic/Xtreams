*Xtreams-Terminals
commit
	self isOtherEndClosed
		 ifFalse: [self sendDone
			ifFalse: ["What to do next ?" self waitForSendDoneFor: 10]]
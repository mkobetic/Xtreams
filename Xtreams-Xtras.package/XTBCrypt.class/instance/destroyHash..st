api-hashes
destroyHash: handle
	
	| status |
	(status := self BCryptDestroyHash: handle) = 0
		ifFalse: [self errorStatus: status]
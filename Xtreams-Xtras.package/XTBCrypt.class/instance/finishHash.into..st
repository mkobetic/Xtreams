api-hashes
finishHash: handle into: buffer
	
	| status |
	(status := self
		BCryptFinishHash: handle
		with: buffer
		with: buffer size
		with: 0) = 0 ifFalse: [self errorStatus: status]
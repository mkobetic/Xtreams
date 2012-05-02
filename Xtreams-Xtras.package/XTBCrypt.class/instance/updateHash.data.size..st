api-hashes
updateHash: handle data: data size: size
	
	| status |
	(status := self BCryptHashData: handle with: data with: size with: 0) = 0
		ifFalse: [self errorStatus: status]
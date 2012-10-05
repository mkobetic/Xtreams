api-general
closeAlgorithmProvider: provider
	
	| status |
	(status := self BCryptCloseAlgorithmProvider: provider with: 0) = 0
		ifFalse: [self errorStatus: status]
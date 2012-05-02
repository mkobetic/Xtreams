private
put: value on: aWriteStream
	^ aWriteStream put: (Character digitValue: value) asLowercase
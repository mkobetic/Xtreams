private
actualWidth
	^ (sign ifNil: [0] ifNotNil: [1]) 
		+ whole size 
		+ (fraction isEmpty ifTrue: [0] ifFalse: [1]) 
		+ fraction size
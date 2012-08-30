accessing - writing
writePosition: aPosition
	^writePosition := (aPosition max: 0) min: dataLength
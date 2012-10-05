initialize-release
close
	position < destination size ifTrue: [destination := destination copyFrom: 1 to: (position min: length)]
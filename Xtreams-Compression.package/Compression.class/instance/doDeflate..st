"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
doDeflate: finish

	| errno |
	errno := library cDeflate: library zstream flush: (finish ifTrue: [library Z_FINISH] ifFalse: [library Z_SYNC_FLUSH]).
	errno == library Z_OK ifTrue: [^false].
	errno == library Z_STREAM_END ifTrue: [^true].
	self error: (library errorStringFor: errno)
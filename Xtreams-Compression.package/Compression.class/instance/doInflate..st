"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
doInflate: finish

	| errno |
	errno := library cInflate: library zstream flush: (finish ifTrue: [library Z_FINISH] ifFalse: [library Z_NO_FLUSH]).
	errno == library Z_OK ifTrue: [^false].
	"We normally get Z_BUF_ERROR instead of Z_STREAM_END, because we often finish the input before we can use Z_FINISH."
	(errno == library Z_STREAM_END or: [errno == library Z_BUF_ERROR and: [finish]]) ifTrue: [^true].
	self error: (library errorStringFor: errno)
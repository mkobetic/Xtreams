initialize-destroy
acceptFrom: aSocketHandle
	"Initialize a new socket handle from an accept call"

	^ self acceptFrom: aSocketHandle receiveBufferSize: 8000 sendBufSize: 8000 

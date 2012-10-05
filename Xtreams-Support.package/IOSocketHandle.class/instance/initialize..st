initialize-destroy
initialize: sockType
	"Initialize a new socket handle. If socket creation fails, socketHandle will be set to nil."

	^ self initialize: sockType network: 0 receiveBufferSize: 8000 sendBufferSize: 8000


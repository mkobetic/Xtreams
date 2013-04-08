"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
cleanup
	"Release all the locks."
	availableChannelsLock signal.
	channelsMutex critical: [
		channels do: [:substream |
			substream == nil ifFalse: [substream closed]]]
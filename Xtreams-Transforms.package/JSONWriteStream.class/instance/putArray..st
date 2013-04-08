"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: actions
"
putArray: aCollection
	<action: #{Core.Array}>
	<action: #{Core.ByteArray}>
	<action: #{Core.WordArray}>
	<action: #{Core.DwordArray}>
	<action: #{Core.OrderedCollection}>
	<action: #{Core.Set}>
	<action: #{Core.IdentitySet}>

	self trackingDepthDo: [
		destination write: '['.
		aCollection
			do: [ :element | self put: element ]
			separatedBy: [ destination write: ','; space].
		destination write: ']' ]
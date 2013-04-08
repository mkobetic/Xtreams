"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: actions
"
putDictionary: aDictionary
	<action: #{Core.Dictionary}>
	<action: #{Core.IdentityDictionary}>

	self putObjectWith: [ :emitKeyValue |
		aDictionary keysAndValuesDo: [ :key :value |
			emitKeyValue value: key value: value ] ]
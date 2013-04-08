"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - receiving
"
process: name object: object start: start stop: stop
	name = 'message' ifTrue:
		[ | command origin parameters |
		origin := object at: 1.
		command := object at: 2.
		parameters := (object at: 4) isNil
			ifTrue:	[(object at: 3) asArray]
			ifFalse:	[(object at: 3) asArray, (Array with: (object at: 4))].

		"Handle CTCP commands in a naive way (don't bother with embedded commands)"
		((command = #PRIVMSG or: [command = #NOTICE]) and: [parameters last first = 1 asCharacter]) ifTrue:
			[ | textstream text subcommand |
			textstream := parameters last reading.
			textstream ++ 1.
			subcommand := (textstream ending: Character space) rest.
			subcommand last = 1 asCharacter ifTrue: [subcommand := subcommand allButLast: 1].
			text := (textstream ending: 1 asCharacter) rest.
			parameters at: parameters size put: text.
			command := (command, '_', subcommand) asSymbol].

		self triggerEvent: #input withArguments: (Array with: command with: origin with: parameters).
		self triggerEvent: command withArguments: (Array with: origin with: parameters).
		^object].
	name = 'command' ifTrue: [^(String withAll: object) asSymbol].
	name = 'reply' ifTrue:
		[ | number |
		number := (String withAll: object) asNumber.
		number > Replies size ifTrue: [^number printString asSymbol].
		^(Replies at: number) ifNil: [number printString asSymbol]].
	name = 'trailing' ifTrue: [^String withAll: (object at: 3)].
	name = 'prefix' ifTrue: [^String withAll: (object at: 2)].
	name = 'param' ifTrue: [^String withAll: (object at: 3)].
	^object
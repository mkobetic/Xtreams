"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - channel
"
join: channel
"
   The JOIN command is used by a user to request to start listening to
   the specific channel.  Servers MUST be able to parse arguments in the
   form of a list of target, but SHOULD NOT use lists when sending JOIN
   messages to clients.
"
	self send: 'JOIN' with: channel


"	| queue semaphore |
	semaphore := Semaphore new.
	self when: ('JOIN ', channel) asSymbol send: #signal to: semaphore.
	self send: 'JOIN' with: channel.
	semaphore wait.
	self removeActionsForEvent: ('JOIN ', channel) asSymbol.

	queue := SharedQueue new.
	self when: ('PRIVMSG ', channel) asSymbol do: [:from :text | queue add: (Array with: from with: text)].
	^queue reading"
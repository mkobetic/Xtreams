{{{
	username := 'xtreams', (Random new reading get * 1000000) floor printString.
	connection := Xtreams.IRC new.
	connection when: #input do: [:command :origin :args |
		Transcript cr; nextPutAll: '> '; nextPutAll: command; space; print: args].
	connection when: #output do: [:command :origin :args |
		Transcript cr; nextPutAll: '< '; nextPutAll: command; space; print: args].
	connection when: #PRIVMSG do: [:origin :args |
		Transcript
			cr; tab; nextPutAll: args first; nextPutAll: ' | ';
			nextPutAll: (connection nickname: origin); nextPutAll: ' > '; nextPutAll: args last].
	connection when: #PRIVMSG_ACTION do: [:origin :args |
		Transcript
			cr; tab; nextPutAll: args first; nextPutAll: ' | * ';
			nextPutAll: (connection nickname: origin); space; nextPutAll: args last].
	
	connection connect: 'irc.parcplace.net'.
	connection login: username realname: 'Xtreams IRC Experiment'.
	connection join: '#smalltalk'.
	
	connection part: '#smalltalk'.
	connection disconnect.
}}}
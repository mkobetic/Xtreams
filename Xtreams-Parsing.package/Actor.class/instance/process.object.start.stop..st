"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
process: name object: object start: start stop: stop
	| action |
	action := actions at: name ifAbsent: [^object].
	^action value: object
initialize-release
process: name object: object start: start stop: stop
	| action |
	action := actions at: name ifAbsent: [^object].
	^action value: object
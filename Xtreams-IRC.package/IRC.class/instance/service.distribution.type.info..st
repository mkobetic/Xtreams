"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - connection
"
service: nickname distribution: distribution type: type info: info
"
   The SERVICE command to register a new service.  Command parameters
   specify the service nickname, distribution, type and info of a new
   service.
"
	self send: 'SERVICE' from: nil withArguments: (OrderedCollection new
		add: nickname;
		add: '*';
		add: distribution;
		add: type;
		add: '0';
		yourself) asArray text: info
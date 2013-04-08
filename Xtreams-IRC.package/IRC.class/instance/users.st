"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - optional
"
users
"
   The USERS command returns a list of users logged into the server in a
   format similar to the UNIX commands who(1), rusers(1) and finger(1).
   If disabled, the correct numeric MUST be returned to indicate this.
"
	self send: 'USERS'
"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: commands - connection
"
oper: opername password: password
"
   A normal user uses the OPER command to obtain operator privileges.
"
	self send: 'OPER' with: opername with: password
"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: procedures
"
copyMemoryTo: destination from: source size: length
	self memmove: destination with: source with: length
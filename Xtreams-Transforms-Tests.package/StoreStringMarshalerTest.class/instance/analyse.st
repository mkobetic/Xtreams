"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
analyse
	bytes := stream conclusion.
	log := (bytes reading encoding: #utf8) rest.
	marshaling := bytes reading marshaling: marshaler class new
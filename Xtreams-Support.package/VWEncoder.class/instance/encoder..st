"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
encoder: anEncoder

	skipRecord := PositionRecord new.
	encoder := anEncoder.
	encoder skipRecord: skipRecord.
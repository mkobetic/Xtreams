"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
trackingDepthDo: aBlock

	depth < 0 ifTrue: [ self error: 'Error: maximum object traversal depth exceeded.'.].
	depth := depth - 1.
	aBlock ensure: [depth := depth + 1]
accessing
update: count from: collection at: start
	
	input replaceFrom: 1 to: count with: collection startingAt: start.
	hash update: count from: input
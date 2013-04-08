"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
initializeReplies
	^(Array new: 606)
		at: 001 put: #RPL_WELCOME;
		at: 002 put: #RPL_YOURHOST;
		at: 003 put: #RPL_CREATE;
		at: 004 put: #RPL_MYINFO;
		at: 005 put: #RPL_BOUNCE;

		at: 302 put: #RPL_USERHOST;
		at: 303 put: #RPL_ISON;

		at: 301 put: #RPL_AWAY;
		at: 305 put: #RPL_UNAWAY;
		at: 306 put: #RPL_NOAWAY;

		at: 311 put: #RPL_WHOISUSER;
		at: 312 put: #RPL_WHOISSERVER;
		at: 313 put: #RPL_WHOISOPERATOR;
		at: 317 put: #RPL_WHOISIDLE;
		at: 318 put: #RPL_ENDOFWHOIS;
		at: 319 put: #RPL_WHOISCHANNELS;

		at: 314 put: #RPL_WHOWASUSER;
		at: 369 put: #RPL_ENDOFWHOWAS;

		at: 321 put: #RPL_LISTSTART;
		at: 322 put: #RPL_LIST;
		at: 323 put: #RPL_LISTEND;

		at: 325 put: #RPL_UNIQOPIS;
		at: 324 put: #RPL_CHANNELMODEIS;
		at: 331 put: #RPL_NOTOPIC;
		at: 332 put: #RPL_TOPIC;
		at: 333 put: #RPL_TOPICINFO;

		at: 341 put: #RPL_INVITING;
		at: 342 put: #RPL_SUMMONING;
		at: 346 put: #RPL_INVITELIST;
		at: 347 put: #RPL_ENDOFINVITELIST;

		at: 348 put: #RPL_EXCEPTLIST;
		at: 349 put: #RPL_ENDOFEXCEPTLIST;

		at: 351 put: #RPL_VERSION;
		at: 352 put: #RPL_WHOREPLY;
		at: 315 put: #RPL_ENDOFWHO;

		at: 353 put: #RPL_NAMEREPLY;
		at: 366 put: #RPL_ENDOFNAMES;
		
		at: 364 put: #RPL_LINKS;
		at: 365 put: #RPL_ENDOFLINKS;

		at: 367 put: #RPL_BANLIST;
		at: 368 put: #RPL_ENDOFBANLIST;

		at: 371 put: #RPL_INFO;
		at: 374 put: #RPL_ENDOFINFO;

		at: 375 put: #RPL_MOTDSTART;
		at: 372 put: #RPL_MOTD;
		at: 376 put: #RPL_ENDOFMOTD;

		at: 381 put: #RPL_YOUREOPER;
		at: 382 put: #RPL_REHASHING;
		at: 383 put: #RPL_YOURESERVICE;
		at: 391 put: #RPL_TIME;

		at: 392 put: #RPL_USERSSTART;
		at: 393 put: #RPL_USERS;
		at: 394 put: #RPL_ENDOFUSERS;
		at: 395 put: #RPL_NOUSERS;

		at: 200 put: #RPL_TRACELINK;
		at: 201 put: #RPL_TRACECONNECTING;
		at: 202 put: #RPL_TRACEHANDSHAKE;
		at: 203 put: #RPL_TRACEUNKNOWN;
		at: 204 put: #RPL_TRACEOPERATOR;
		at: 205 put: #RPL_TRACEUSER;
		at: 206 put: #RPL_TRACESERVER;
		at: 207 put: #RPL_TRACESERVICE;
		at: 208 put: #RPL_TRACENEWTYPE;
		at: 209 put: #RPL_TRACECLASS;
		at: 210 put: #RPL_TRACERECONNET;
		at: 261 put: #RPL_TRACELOG;
		at: 262 put: #RPL_TRACEEND;

		at: 211 put: #RPL_STATSLINKINFO;
		at: 212 put: #RPL_STATSCOMMANDS;
		at: 219 put: #RPL_ENDOFSTATS;
		at: 242 put: #RPL_STATSUPTIME;
		at: 243 put: #RPL_STATSOLINE;
		at: 265 put: #RPL_STATSLUSERS;
		at: 266 put: #RPL_STATSGUSERS;

		at: 221 put: #RPL_UMODEIS;

		at: 234 put: #RPL_SERVLIST;
		at: 235 put: #RPL_SERVLISTEND;

		at: 251 put: #RPL_LUSERCLIENT;
		at: 252 put: #RPL_LUSEROP;
		at: 253 put: #RPL_LUSERUNKNOWN;
		at: 254 put: #RPL_LUSERCHANNELS;
		at: 255 put: #RPL_LUSERME;

		at: 256 put: #RPL_ADMINME;
		at: 257 put: #RPL_ADMINLOC1;
		at: 258 put: #RPL_ADMINLOC2;
		at: 259 put: #RPL_ADMINEMAIL;

		at: 263 put: #RPL_TRYAGAIN;

		at: 401 put: #ERR_NOSUCHNICK;
		at: 402 put: #ERR_NOSUCHSERVER;
		at: 403 put: #ERR_NOSUCHCHANNEL;
		at: 404 put: #ERR_CANNOTSENDTOCHAN;
		at: 405 put: #ERR_TOOMANYCHANNELS;
		at: 406 put: #ERR_WASNOSUCHNICK;
		at: 407 put: #ERR_TOOMANYTARGETS;
		at: 408 put: #ERR_NOSUCHSERVICE;
		at: 409 put: #ERR_NOORIGIN;
		at: 411 put: #ERR_NORECIPIENT;
		at: 412 put: #ERR_NOTEXTTOSEND;
		at: 413 put: #ERR_NOTOPLEVEL;
		at: 414 put: #ERR_WILDTOPLEVEL;
		at: 415 put: #ERR_BADMASK;
		at: 421 put: #ERR_UNKNOWNCOMMAND;
		at: 422 put: #ERR_NOMOTD;
		at: 423 put: #ERR_NOADMININFO;
		at: 424 put: #ERR_FILEERROR;
		at: 431 put: #ERR_NONICKNAMEGIVEN;
		at: 432 put: #ERR_ERRORNEOUSNICKNAME;
		at: 433 put: #ERR_NICKNAMEINUSE;
		at: 436 put: #ERR_NICKCOLLISION;
		at: 437 put: #ERR_UNAVAILRESOURCE;
		at: 441 put: #ERR_USERNOTINCHANNEL;
		at: 442 put: #ERR_NOTONCHANNEL;
		at: 443 put: #ERR_USERONCHANNEL;
		at: 444 put: #ERR_NOLOGIN;
		at: 445 put: #ERR_SUMMONDISABLED;
		at: 446 put: #ERR_USERSDISABLED;
		at: 451 put: #ERR_NOTREGISTERED;
		at: 461 put: #ERR_NEEDMOREPARAMS;
		at: 462 put: #ERR_ALREADYREGISTERED;
		at: 463 put: #ERR_NOPERMFORHOST;
		at: 464 put: #ERR_PASSWORDMISMATCH;
		at: 465 put: #ERR_YOUREBANNECREEP;
		at: 466 put: #ERR_YOUWILLBEBANNED;
		at: 467 put: #ERR_KEYSET;
		at: 471 put: #ERR_CHANNELISFULL;
		at: 472 put: #ERR_UNKNOWNMODE;
		at: 473 put: #ERR_INVITEONLYCHAN;
		at: 474 put: #ERR_BANNEDFROMCHAN;
		at: 475 put: #ERR_BADCHANNELKEY;
		at: 476 put: #ERR_BADCHANMASK;
		at: 477 put: #ERR_NOCHANMODES;
		at: 478 put: #ERR_BANLISTFULL;
		at: 481 put: #ERR_NO_PRIVILEGES;
		at: 482 put: #ERR_CHANOPPRIVSNEEDED;
		at: 483 put: #ERR_CANTKILLSERVER;
		at: 484 put: #ERR_RESTRICTED;
		at: 485 put: #ERR_UNIQOPPRIVSNEEDED;
		at: 491 put: #ERR_NOOPERHOST;
		at: 501 put: #ERR_UMODEUNKNOWNFLAG;
		at: 502 put: #ERR_USERSDONTMATCH;
		at: 510 put: #ERR_MUSTRESOLVENICKNAME;
		at: 511 put: #ERR_SILENTLISTFULL;
		at: 512 put: #ERR_NOSUCHGLINE;
		at: 513 put: #ERR_CANNOTHANDLEPINGPONG;

		at: 600 put: #RPL_WATCHOFFLINE;
		at: 601 put: #RPL_WATCHONLINE;
		at: 602 put: #RPL_STOPPEDWATCHING;
		at: 603 put: #RPL_WATCHINFO;
		at: 604 put: #RPL_WATCHISONLINE;
		at: 605 put: #RPL_WATCHISOFFLINE;
		at: 606 put: #RPL_WATCH;
		
		"Deprecated, Reserved or non-generic features:"
		at: 231 put: #RPL_SERVEINFO;
		at: 232 put: #RPL_ENDOFSERVICES;
		at: 233 put: #RPL_SERVICE;
		at: 300 put: #RPL_NONE;
		at: 316 put: #RPL_WHOISCHANOP;
		at: 361 put: #RPL_KILLDONE;
		at: 362 put: #RPL_CLOSING;
		at: 363 put: #RPL_CLOSEEND;
		at: 373 put: #RPL_INFOSTART;
		at: 384 put: #RPL_MYPORTIS;

		at: 213 put: #RPL_STATSCLINE;
		at: 214 put: #RPL_STATNCLINE;
		at: 215 put: #RPL_STATSILINE;
		at: 216 put: #RPL_STATSKLINE;
		at: 217 put: #RPL_STATSQLINE;
		at: 218 put: #RPL_STATSYLINE;
		at: 240 put: #RPL_STATSVLINE;
		at: 241 put: #RPL_STATSLLINE;
		at: 244 put: #RPL_STATSHLINE;
		at: 245 put: #RPL_STATSSLINE;
		at: 246 put: #RPL_STATSPING;
		at: 247 put: #RPL_STATSBLINE;
		at: 250 put: #RPL_STATSDLINE;

		at: 492 put: #ERR_NOSERVICEHOST;

		yourself
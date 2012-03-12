proc(_is_cloaked, assign(@player, player()),
	return(not(equals(pinfo(@player, 0), pinfo(@player, 4))))
)

proc(_cloak_player, @newname, assign(@player, player()),
	set_display_name(@player, @newname)
	
	assign(@key, concat('playerdata.', pinfo(@player, 0), '.displayname'))
	store_value(@key, @newname)
	
	console(@key '=' get_value(@key))
	msg(sconcat(pinfo(@player, 0), 'is now named', @newname))
)

proc(_decloak_player, assign(@player, player()),
	assign(@rawplayer, pinfo(@player, 0))
	assign(@dispname, pinfo(@player, 4))
	
	if(_is_cloaked(@rawplayer),
		clear_value(concat('playerdata', $rawplayer, '.displayname'))
		reset_display_name(@rawplayer)
		
		msg(@dispname 'is now known as' @rawplayer)
	, # else
		tmsg(@player, 'You currently aren\'t cloaked.')
	)
)

proc(_player_joined, @player,
	assign(@key, concat('playerdata.', pinfo(@player, 0), '.displayname'))
	assign(@newname, get_value(@key))
	
	if(not(is_null(@newname)),
		set_display_name(@player, @newname)
		console('Renamed' @player 'to' @newname)
	, # else
		console(@player 'not being cloaked.')
	)
)
		 
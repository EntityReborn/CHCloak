proc(_is_cloaked, assign(@player, player()),
	return(not(equals(pinfo(@player, 0), pinfo(@player, 4))))
)

proc(_cloak_player, @newname, assign(@player, player()),
	if(not(has_permission(pinfo(@player, 0), 'cloak.apply')),
		msg(concat(color(red), 'You do not have permission to cloak!'))
		return(false)
	)
	
	set_display_name(@player, @newname)
	
	assign(@key, concat('entityreborn.playerdata.', pinfo(@player, 0), '.displayname'))
	store_value(@key, @newname)
	
	broadcast(pinfo(@player, 0) 'is now known as' @newname)
)

proc(_decloak_player, assign(@player, player()),
	assign(@rawplayer, pinfo(@player, 0))
	
	if(not(has_permission(@rawplayer, 'cloak.remove')),
		msg(concat(color(red), 'You do not have permission to decloak!'))
		return(false)
	)
	
	assign(@dispname, pinfo(@player, 4))
	
	if(_is_cloaked(@rawplayer),
		clear_value(concat('entityreborn.playerdata.', @rawplayer, '.displayname'))
		reset_display_name(@rawplayer)
		
		broadcast(@dispname 'is now known as' @rawplayer)
	, # else
		tmsg(@player, 'You currently aren\'t cloaked.')
	)
)

proc(_player_joined, @player,
    if(not(has_permission(@player, 'cloak.cloakonjoin')),
		return(false)
	)
    
	assign(@key, concat('entityreborn.playerdata.', pinfo(@player, 0), '.displayname'))
	assign(@newname, get_value(@key))
	
	if(not(is_null(@newname)),
		set_display_name(@player, @newname)
	)
)
		 
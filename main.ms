bind(player_join, null, null, @event,
	_player_joined(@event[player])
	modify_event('join_message', concat(color(yellow), pinfo(@event['player'], 4) 'joined the game.'))
) 
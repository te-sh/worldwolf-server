module RoomCable
  def broadcast
    update_column(:last_access, Time.now)
    reload
    run('room', as_json(Room::JSON_DETAIL))
  end

  def broadcast_chat(user, text)
    run('chat', action: 'chat', user: user.name, text: text)
  end

  def broadcast_enter(user)
    broadcast
    run('chat', action: 'enter', user: user.name)
  end

  def broadcast_leave(user)
    broadcast
    run('chat', action: 'leave', user: user.name)
  end

  def broadcast_set_game(user)
    broadcast
    run('chat', action: 'set-game', user: user.name)
  end

  def broadcast_start_game(user)
    broadcast
    run('chat', action: 'start-game', user: user.name)
  end

  def broadcast_finish_game(reason)
    broadcast
    run('chat', action: 'finish-game', reason: reason)
  end

  def broadcast_game(game)
    broadcast
    run('chat', action: 'game', game: game.as_json(Game::JSON_DETAIL))
  end

  def broadcast_votes(votes)
    broadcast
    run('chat', action: 'votes', votes: votes.as_json(Vote::JSON))
  end

  def broadcast_expire
    run('chat', action: 'expire')
  end

  def run(target, data)
    ActionCable.server.broadcast("room-#{id}", target: target, data: data)
  end
end

module UserCable
  def broadcast_word(word)
    run('chat', action: 'word', word: word)
  end

  def broadcast_votes(votes)
    run('votes', votes.as_json(Vote::JSON))
  end

  def run(target, data)
    ActionCable.server.broadcast("user-#{id}", target: target, data: data)
  end
end

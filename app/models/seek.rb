class Seek

	def self.create(player)
		if opponent = REDIS.spop("seeks")
			Game.start(player.username, opponent)
			remove()
	end

end
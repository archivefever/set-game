class Seek
  def self.create(current_user)
    if opponent = REDIS.spop("seeks")
      Game.start(current_user.username, opponent)
      # remove(current_user.username)
      # remove(opponent)
      clear_all
    else
      REDIS.sadd("seeks", current_user.username)
    end
  end

# argument is a string
  def self.remove(current_user)
    REDIS.srem("seeks", current_user)
  end

  def self.clear_all
    REDIS.del("seeks")
  end
end
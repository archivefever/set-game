class Seek
  def self.create(current_user)
    if opponent = REDIS.spop("seeks")
      Game.start(current_user.username, opponent)
    else
      REDIS.sadd("seeks", current_user.username)
    end
  end

  def self.remove(current_user)
    REDIS.srem("seeks", current_user.username)
  end

  def self.clear_all
    REDIS.del("seeks")
  end
end
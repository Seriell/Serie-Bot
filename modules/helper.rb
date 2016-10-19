module SerieBot
  module Helper

    def self.isadmin?(member)
      Config.bot_owners.include?(member) or member.id == 228574821590499329
    end
  end
 end
  
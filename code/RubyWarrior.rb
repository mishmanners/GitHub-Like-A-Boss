# Ruby Warrior - code for Ruby Warrior game, level 10

class Player
    def play_turn(warrior)
      @player_state = 1 unless @player_state
      @health = warrior.health unless @health
      # @player_state = 0 if warrior.feel.empty?
      @player_state = 6 if warrior.feel.wall?
      @player_state = 0 if warrior.feel(:backward).wall?
      @player_state = 3 if warrior.feel.enemy?
      # @player_state = 7 if warrior.look && warrior.feel.enemy?
      @player_state = 0 if warrior.look[0].empty?
      @player_state = 7 if warrior.look[1].enemy? || warrior.look[2].enemy?
      @player_state = 0 if warrior.look[1].captive? || warrior.look[2].captive?
      @player_state = 6 if warrior.look(:backward)[2].enemy?
      @player_state = 6 if warrior.look(:backward)[1].captive?
      @player_state = 0 if @player_state == 2 && warrior.health >= 20
      @player_state = 2 if warrior.health < @health && !warrior.feel.empty?
      @player_state = 1 if @player_state == 2 && @health > warrior.health
      @player_state = 2 if warrior.health < 14 && warrior.feel.empty? && warrior.health >= @health
      @player_state = 6 if warrior.health < @health && warrior.look(:backward)[2].enemy?
      @player_state = 4 if warrior.feel.captive?
  
      case @player_state
        when 0
          warrior.walk!
        when 1
          warrior.walk!(:backward)
        when 2
          warrior.rest!
        when 3
          warrior.attack!
        when 4
          warrior.rescue!
          @player_state = 0
        when 5
          warrior.rescue!(:backward)
          @player_state = 0
        when 6
          warrior.pivot!
        when 7
          warrior.shoot!
      end
  
  
      @health = warrior.health
    end
  end
  
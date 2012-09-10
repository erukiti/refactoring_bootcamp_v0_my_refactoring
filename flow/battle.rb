# coding: utf-8

class DeadException < Exception ; end
class DarkException < Exception ; end

class Character
  attr_reader :life
  attr_reader :defence
  attr_reader :element

  def initialize(life, atack, defence, element)
    @life = life
    @atack = atack
    @defence = defence
    @element = element
  end

  def elemental_bonus?(defencer)
    (@element == :water && defencer.element == :fire) ||
    (@element == :fire && defencer.element == :water) ||
    (@element == :wind && defencer.element == :earth) ||
    (@element == :earth && defencer.element == :wind)
  end

  def get_damage(damage)
    if @life <= damage
      @life = 0
      raise DeadException
    else
      @life -= damage
    end
  end

  def atack(defencer)
    raise DarkException if @element == :dark || defencer.element == :dark
    return if @atack <= defencer.defence

    damage = @atack - defencer.defence
    damage *= 2 if elemental_bonus?(defencer)
    defencer.get_damage(damage)
  end
end

class Battle
  attr_reader :turn

  def initialize(first, second)
    @first = first
    @second = second
    @turn = 1
  end

  def start
    loop do
      begin
        @first.atack(@second)
      rescue DeadException
        return @first
      rescue DarkException
        return nil
      end

      begin
        @second.atack(@first)
      rescue DeadException
        return @second
      rescue DarkException
        return nil
      end

      @turn += 1
    end
  end
end

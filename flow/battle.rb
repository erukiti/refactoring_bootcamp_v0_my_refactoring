# coding: utf-8

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
    else
      @life -= damage
    end
  end

  def dead?
    @life == 0
  end

  def atack(defencer)
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
    return nil if @first.element == :dark || @second.element == :dark
    loop do
      @first.atack(@second)
      return @first if @second.dead?

      @second.atack(@first)
      return @second if @first.dead?

      @turn += 1
    end
  end
end

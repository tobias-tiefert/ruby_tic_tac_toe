class Player
  attr_accessor :name, :sign
  attr_reader :choices

  def initialize(name, sign)
    @name = name
    @sign = sign
    @choices = []
  end

  def add_choice(choice)
    @choices.push(choice)
  end
end

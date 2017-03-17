
module Friendship


class Friend
  attr_accessor :name, :sex, :age

  def initialize(name, sex, age)
    @name = name
    @sex = sex
    @age = age
  end

  def male?
   sex == :male
  end

  def female?
    sex == :female
  end

  def over_eighteen?
    age > 18
  end

  def long_name?
    name.length > 10
  end

  def matches?(criteria)
    criteria.all? do |key, value|
      case key
      when :name then name == value
      when :age then age == value
      when :sex then sex == value
      when :filter then value.(self)
      end
    end
  end

end

class Database
  include Enumerable

  attr_accessor :data

  def initialize(*data)
    @data = data
  end

  def each(&block)
    data.each(&block)
  end

  def add_friend(name, sex, age)
    data << Friendship::Friend.new(name, sex, age)
  end

  def have_any_friends?
    data.any? { |el| el }
  end

  def find(criteria)
    data.select {|friend| friend.matches?(criteria)}
  end

  def unfriend(criteria)
    data.reject! {|friend| friend.matches?(criteria)}
  end

end
end


 maria = Friendship::Friend.new("maria", :female, 20)
# p maria.over_eighteen?
# p maria.long_name?
# p maria.male?



 nini =  Friendship::Friend.new("ninadasdfasdfasdfa", :male, 11)

  data1 = Friendship::Database.new(maria, nini)
    data1.add_friend("petyr", :male, 30)
p  data1.have_any_friends?

 # p data1

 p data1.unfriend(name: 'maria')
 p data1
  p data1.map(&:name)
  # p friend_names = data1.map(&:age)

  # p nini
  # p maria
  # p data1
# p friends_name =  data1.map(&:name)
# p friends_names = data1.each.map(&:name)

  #  p data1.find(name: "maria")

  #  p data1.find(sex: :female)
p  data1.unfriend(filter: ->(friend) { friend.age == 30 })

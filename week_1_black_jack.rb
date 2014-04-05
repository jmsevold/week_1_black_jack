require 'pry'

class Card
  attr_accessor :face, :suit, :value
  
  def initialize(face,suit)
    @face = face
    @suit = suit
    @value = 0
  end
  
  def identify
    if self.face == "Ace"
      letter = "an"
    else
      letter = "a"
    end
    "#{letter} #{@face} of #{@suit}"
  end
end

class Player
  attr_accessor :hand, :player_name, :total, :won, :bust
  
  def initialize
    @hand = []
    @total = 0
    @player_name = ""
    @won = nil
    @bust = nil
  end
  
  def calculate_total
    @hand.each do |card|
      @total += card.value
    end
    @total
  end
  
  def display_hand
    hand_string = []
    @hand.each do |card|
      hand_string << card.identify
    end
    hand_string.join(", ")
  end
end


$deck = []



#create combos of faces & suits
faces = %w{ 2 3 4 5 6 7 8 9 10 Jack King Queen Ace }

suits = %w{ Hearts Spades Diamonds Clubs}



#determine value based on face for cards
def card_value_determiner(card)
  string_nums = (2..10).to_a.map { |i| i.to_s}
  if string_nums.include?(card.face)
    card.value = card.face.to_i
  else
    card.value = 10
  end
end



#create all 52 cards,assign values, & populate deck
faces.each do |face|
  suits.each do |suit|
    c = Card.new(face,suit)
    card_value_determiner(c)
    $deck << c
  end
end


$deck.shuffle






#must be run everytime a card is dealt to a player
def win_or_bust(player)
   if player.calculate_total == 21
      puts "#{player.player_name} got 21 and won the game!"
      player.won = true
   elsif player.calculate_total > 21
      puts "#{player.player_name} busted and loses!"
      player.bust = true
   end
end



#prompt the player
def hit_or_stay(player)
  stay = false
  until stay == true
  puts "Will #{player.player_name} hit or stay?"
  answer = gets.chomp.downcase
  if answer == "hit"
    deal_card($deck,player)
  elsif answer == 'stay'
    stay == true
  end
end


def first_deal($deck,player)
  c1 = $deck.pop
  c2 = $deck.pop
  player.hand.push(c1,c2)
  puts"#{player.player_name} received a #{player.hand.last.identify}"
  puts"#{player.player_name} received a #{player.hand[-2].identify}"
  puts "Current hand: "
  player.display_hand
  win_or_bust(player)
  hit_or_stay(player)
end



def deal_card($deck, player)
  card = $deck.pop
  player.hand.push(card)
  puts"#{player.player_name} received a #{player.hand.last.identify}"
  puts "Current hand: "
  player.display_hand
  win_or_bust(player)
  hit_or_stay(player)
end



   
def ace_prompt(card,player)
  if card.face == "Ace"
    puts "Would #{player.player_name} like this Ace to be worth 11 or 1?"
    answer = gets.chomp
    if answer == '1'
      card.value = 1
    elsif answer == '11'
      card.value == 11
    end
  end
end


until game_over?(user) || game_over?(dealer)
end
puts "Thank you for playing!"


  
user = Player.new
dealer = Player.new
dealer.player_name = "Dealer"
puts "Welcome to Blackjack! What is your name?"
name = gets.chomp
user.player_name = name
puts "Let's get started!"




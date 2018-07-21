class Card
	
	SUITS = ["Diamonds", "Clubs", "Spades", "Hearts"]
	NUMS  = [ "2", "3", "4", "5", "6", "7", "8", "9", "10", "K", "Q", "J", "A"]


	# suit stores suit value and num store the card number
	attr_accessor :suit, :num, :val
	
	#function to initialize suit value
	def initialize(num, suit) 
		@suit = suit
		@num = num
	end

	#function to change the face value to an integer from cdeck
	def val
		if num == "A"
			val = 11
		elsif num == "J" || num == "K" || num == "Q"
			val = 10
		else
			val = num.to_str
		end
		val 
	end

	def to_s
      "Suit: #{@suit}, Card: #{@num}, Value: #{val}"
    end

end

class Deck

	attr_accessor :deck
	
	#initializer will initialize the deck
	def initialize
		@deck = []
		Card::SUITS.each do |suit|
			Card::NUMS.each do |num|
				@deck.push(Card.new(num, suit))
			end
		end
	end


	#withdraw a card from deck
	def withdraw
		@deck.pop
	end

	#We need to shuffle the cards as well
	def shuffle
		@deck.shuffle!
	end
end

$persons_deck  = [] # Deck of person can be player or the dealer, used by NewGame class and Person class. 

class Person

	#card is the list of card which a player would have and total_val will store the sum of num value for every player
	attr_accessor :card, :total_val

	def initialize
		@cards = []
		@total_val = 0
	end

	# when a player choose to hit
	def hit
	    c = $persons_deck.withdraw
	    @total_val += (c.val).to_i
	    @cards.push(c)
  	end

  	def to_s
    	 "Cards: [#{@cards.map { |x| x.to_s}.join(" ] , [ ")} ], Total Value: #{@total_val}"
    end

  end

# Game logic class as per the instructions. 
class NewGame
	
	$persons_deck = Deck.new
    $persons_deck.shuffle

	def initialize
		player = Person.new
    	player.hit
    	player.hit
    	print "Player's "
		puts player    
		dealer = Person.new
		dealer.hit 	
		print "Dealer's "
		puts dealer  
		if player.total_val == 21
			puts "---------------"
			puts "| Player wins |" 
			puts "---------------"
		else
			until player.total_val > 21 
		    	puts "Hit(h) or Stand(s)"
		    	option = gets.chomp
		    	if option == "h" 
		    		player.hit
		    		print "Player's "
		      		puts player
		    	else
		      		print "Player's Final "
		      		puts player
			   		until dealer.total_val > 16
		    			dealer.hit
		      			print "Dealer's "
		      			puts dealer
			   		end
		      		break
		    	end
			end

			print "Dealer's Final"
	    	puts dealer

	    	if player.total_val > 21
	    		puts "---------------"
	    		puts "| Dealer wins |" 
				puts "---------------"
			end

			if dealer.total_val <= 21 && dealer.total_val >= 16
				if player.total_val > dealer.total_val
			      	puts "---------------"
			      	puts "| Player wins |"
			      	puts "---------------"
			    elsif player.total_val == dealer.total_val
			      	puts "-------------"
			      	puts "|    Draw   |"
			      	puts "-------------"
			    else
			    	puts "---------------"
			      	puts "| Dealer wins |"
			      	puts "---------------"
			    end
			elsif dealer.total_val > 21
				puts "---------------"
				puts "| Player Wins |"
				puts "---------------"
		  	end
		end
	end
end

# NewGame class object to initiate the game.
game = NewGame.new

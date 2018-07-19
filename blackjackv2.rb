$pc
$dc
class Player
		def player_cards # to generate a player card
			pcard = Card.new
			return pcard.generateCard
		end
end

class Dealer
		def dealer_cards
			dcard = Card.new
			return dcard.generateCard
		end
end

class Deck
	attr_accessor :cdeck
	def initialize
		@cdeck = [ 2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'J', 'K', 'Q',
			       2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'J', 'K', 'Q',
			       2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'J', 'K', 'Q',
			       2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'J', 'K', 'Q' ]
	end
	def self.shuffle
		@cdeck.shuffle
	end
end


class Card < Deck
			def generateCard
			card = cdeck[rand(cdeck.length)] # randomly generating a card from cdeck
			if card == 'A'
				val = 11
				cdeck.delete_at(cdeck.index(card) || cdeck.length)
				return val
			elsif card == 'J' || card == 'K' || card == 'Q'
				val = 10
				cdeck.delete_at(cdeck.index(card) || cdeck.length)
				return val
			end
			cdeck.delete_at(cdeck.index(card) || cdeck.length)
			return card
		end
end  

class MasterGame  
	@P = Player.new
	@D = Dealer.new

	@pc1 = @P.player_cards
	@pc2 = @P.player_cards
	@dc = @D.dealer_cards

	sumP = @pc1 + @pc2
	sumD = @dc

	puts "Player Cards: #{@pc1} , #{@pc2}"
	puts "Dealer Card: #{@dc}"
	puts "SUM PLAYER : #{sumP}"
	puts "SUM DEALER : #{sumD}"

	final_dealer = 0
	final_player = 0

	gameS = true # for the game status, used at last to check if the game is over or not to break out of the loop

	loop do 
		if sumP == 21
			puts "Player Wins!"
			break
		elsif sumP > 21
			puts "Dealer Wins!"
			break
		else
			puts "HIT(h) OR STAND(s)"
			opt = gets.chomp
			if opt == 'h'
				ncardP = Card.new
				nc = ncardP.generateCard #new generated card for player
				sumP += nc
				puts "New generated Card for Player: #{nc}"
				puts "Sum PLAYER : #{sumP}"
				puts "SUM DEALER : #{sumD}"
			else # the player stood and dealer will play now
				final_player = sumP
				loop do 
					ncardD = Card.new
					nd = ncardD.generateCard #new generated card for dealer
					sumD += nd
					puts "New generated Card for Dealer: #{nd}"
					puts "SUM PLAYER : #{sumP}"
					puts "SUM DEALER : #{sumD}"
					if sumD == 21
						puts "Dealer wins"
						gameS = false
						break
					elsif sumD > 16 && sumD < 21
						final_dealer = sumD
						if final_dealer > final_player
							puts "Dealer Wins!"
							gameS = false
							break
						elsif final_player > final_dealer
							puts "Player Wins!"
							gameS = false
							break
						else
							puts "Draw"
							gameS = false
							break
						end
					elsif sumD > 21
						puts "Player Wins!"
						gameS = false
						break
					end
				end
				if gameS == false
					break
				end
			end
		end
	end
end


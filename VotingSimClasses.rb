# VotingSimClasses.rb
class World
	attr_accessor :voters, :politicians
	
	def initialize
		#Set up empty arrays to store the voters and the politicians
		@voters = []
		@politicians = []
	end

	def add_person(person)
		#Checks if the person object passed in is a politician or not
		#If the person is a politician, then add them to the politicians array
		#If not, add them to the voters array
		person.politician ? @politicians << person : @voters << person
	end

	def remove_person(person)
		#Checks if the person object passed in is a politician or not
		#If the person is a politician, then delete them to the politicians array
		#If not, delete them to the voters array
		person.politician ? @politicians.delete(person) : @voters.delete(person)
	end

	def list
		#Go through each person in the voters array
		#Puts to the screen their name and political view
		@voters.each do |voter|
			puts "Voters: #{voter.name}, #{voter.view}" 
		end
		#Go through each person in the politicians array
		#Puts to the screen their name and party
		@politicians.each do |politician|
			puts "Politicians: #{politician.name}, #{politician.party}"
		end

		puts "Press enter to continue."
		gets
	end

	def vote
		#Sets the vote attribute for each voter in the voter array
		@voters.each do |voter|
			#Tell the user whose speach each voter listened to
			puts "#{voter.name} listened to #{@politicians.sample.name}'s speach."
			#Set up hash with the probabilities of each political view
			views = {"liberal" => 75, "socialist" => 90, "neutral" => 50, "conservative" => 25, "tea party" =>10}
			#If the random number generator outputs a number higher than the hash value associated with the voter's views
			#then that means they are voting for the republican. If it isn't higher, than they vote for the democrat
			(Random.new.rand(100) + 1) > views[voter.view] ? voter.vote = "republican" : voter.vote = "democrat"
			
			#Checks if the voter changed their mind
			#Here we assume that if a liberal or socialist votes republican, that means they changed their mind
			if (voter.view == "liberal" || voter.view == "socialist") && voter.vote == "republican"
				puts "#{voter.name} changed their mind."
			#Here we assume that if a conservative or tea party votes democrat, that means they changed their mind
			elsif (voter.view == "conservative" || voter.view == "tea party") && voter.vote == "democrat"
				puts "#{voter.name} changed their mind."
			end
			#Output which party the voter will be voting for
			puts "#{voter.name} will be voting for the #{voter.vote}."
		end
		
		#Tell the user whose speach each politician listened to
		@politicians.each do |politician|
			#Sets speaker equal to a random politician
			speaker = politicians.sample
			#Checks to make sure that the random politician isnt the same as the one listening to the speach
			while speaker == politician
				speaker = politicians.sample
			end
			#Tells the user that the politician thinks the speaker is unfit for office
			puts "#{politician.name} listened to #{speaker.name}'s speach.\n#{politician.name} says that #{speaker.name} is unfit for office."
			#Sets the politician's vote attribute to their own party
			politician.vote = politician.party
		end	
		#sets the number of votes the democrats and republicans have to 0
		republican_votes = democrat_votes = 0
		#loops through all politicians and voters
		[@voters, @politicians].each do |group|
			#loops through all people in the current group
			group.each do |voter|
				#If the person's vote is republican, then add one vote to the republican votes
				#Otherwise add one to the democrats votes
				voter.vote == "republican" ? republican_votes +=1 : democrat_votes +=1
			end
		end
		
		#This is where the primaries are held
		#Republican winner and democrat winners are set to nil
		republican_winner = democrat_winner = nil
		#Loops until a winner is found for both the democrats and republicans
		while republican_winner.nil? || democrat_winner.nil?
			#gets a random politician
			primaries = politicians.sample
			#if the random politician is a republican, then they win the republican primary
			#Otherwise they win the democrat primary
			primaries.party == "republican" ? republican_winner = primaries : democrat_winner = primaries
		end

		#Determine the winner by whoever has more votes
		#If its a tie, tell the user and suggest adding an odd number of people next simulation
		if democrat_votes > republican_votes
			puts "#{democrat_winner.name} the Democrat wins!"
		elsif republican_votes > democrat_votes
			puts "#{republican_winner.name} the republican wins."
		else
			puts "It's a tie! Try adding an odd number of people next time."
		end
	end
end

class Person
	attr_accessor :name, :view, :party, :politician, :vote
	
	def initialize(name, view, party, politician)
		#Sets up each new person
		@name = name
		@view = view
		@party = party
		#Politician is a boolean. It identifies whether or not the person is a politician
		@politician = politician
	end
end
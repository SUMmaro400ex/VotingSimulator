#VoterSim.rb
require "./VotingSimMethods.rb"
require "./VotingSimClasses.rb"
include VotingSimMethods

# create instance of the world class. Politicians and voters are added and manipulated here
world = World.new

#Loops until it is time to vote. Once it is time to vote, the voting is done and the program completes
time_to_vote=false
until time_to_vote
	
	#Main menu options
	options=["create","list", "update", "vote"]
	#Uses the get_input method to get and validate the users input
	choice = get_input("What would you like to do? Create, List, Update, or Vote", options)
	#case statement. Switches on the choice the user made
	case choice
	when "create"
		#Calls the create method and passes in the instance of the world class created earlier
		create(world)
	when "list"
		#Calls the list method of the world object
		world.list
	when "update"
		#Check if there are any in the world. Can't update if the world is empty
		if world.voters.empty? && world.politicians.empty?
			puts "Sorry, there is no one available to update.\nPlease press enter to continue"
			gets
		else
			#Calls the update method and passes in the instance of the world class created earlier
			update(world)
		end
	when "vote"
		#Checks whether there is atleast one republican and one democrat
		#Can't have an election until there is atleast one of each
		republican = democrat = false
		world.politicians.each do |politician|
			politician.party == "republican" ? republican = true : democrat = true
		end

		if republican && democrat
			#If there is atleast one republican and one democrat, then hold the election
			#Calls the vote method of the world object
			world.vote
			#Time to vote is changed to true. This allows the loop to finish and program to end
			time_to_vote = true
		else
			#Tells the user that you must have atleast one republican and one democrat
			puts `clear` 
			puts "You must have at least one republican and one democrat to run the simulation.\nPress enter to continue."
			gets
		end
	end
end



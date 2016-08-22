# ===============================================
# Gems
# ===============================================
require 'rubygems'
require 'discordrb'
require 'json'

# ===============================================
# Local Files
# ===============================================
require_relative './BattleNet/BattleNet'

tc = '';
bot = Discordrb::Commands::CommandBot.new token: 'MjE2MTkyNjUwMjM4MzYxNjAx.CpigoA.7yutKMWJraKvVXmmM3ppAWQaORQ', application_id: 216192650238361601, prefix: '!'

# ===============================================
# Default Ping response
# ===============================================
bot.command( :ping, :description => 'Basic Ping-Pong Response.') do |event|
	event.respond 'pong'
end

# ===============================================
# Addons Out
# ===============================================
bot.command( :addons, :description => 'Returns the addons that are required to participate in particular events with the guild.', :usage => '!addons - for PvP addons, !addons pve - for PvE addons' ) do |event, type|
	if type.eql? 'pve'
		event.respond 'Wretched requires the following WoW Addons:'
		event.respond '1. Deadly Boss Mods - https://mods.curse.com/addons/wow/deadly-boss-mods'
		event.respond '*You must have these installed to participate in Guild organized Raids.*'
	else
		event.respond 'Wretched requires the following WoW Addons:'
		event.respond '1. Battleground Targets - https://mods.curse.com/addons/wow/battlegroundtargets'
		event.respond '2. Healers Have to Die - https://mods.curse.com/addons/wow/healers-have-to-die'
		event.respond '*You must have these installed to participate in Guild organized RBGs.*'
	end
end

# ===============================================
# Guildmaster
# ===============================================
bot.command( :guildmaster, :description => 'Will send the Guild Master\'s name and BattleTag to the user as a Direct Message.' ) do |event|
	event.user.pm( 'The guildmaster is Lokien. His BattleTag is XtasyArmada#1751' )
end

# ===============================================
# Random Roll
# ===============================================
bot.command( :roll, :description => 'Will generate a random number.', :usage => 'Defaults to a number between 1 and 100, unless min and max are explicitly expressed. (e.g., !roll 1 100' ) do |event, min, max|
	if min && max
		rand( min.to_i .. max.to_i )
	else
		rand( 1 .. 100 )
	end
end

# ===============================================
# Realm Status
# ===============================================
bot.command( :realmstatus, :description => 'Will check realm status for connected realms.' ) do |event|
	realms = ['anubarak', 'nathrezim', 'garithos', 'smolderthorn', 'crushridge']

	status = BattleNet.realm_status( realms, 'q6k9yhwahdvafnmn58qsk3ubnn6sheer' )
	allRealms = status['realms']

	allRealms.each do |realm|
		# if realms.include? realm['slug']
			name = realm['name']
			state = realm['status'] ? 'UP' : 'DOWN'
			message = name + ' is ' + state
			event.respond '```' + message + '```'
		# end
	end
end

# ===============================================
# Arena Ratings
# ===============================================
bot.command( :ratings, :description => 'Will retrieve the PvP ratings for the provided character.', :usage => '!ratings Lokien-Anub\'arak' ) do |event, toon|	
	charArray = toon.split( '-' )
	name = charArray[0]
	realm = charArray[1]

	response = BattleNet.character_pvp( name, realm, 'q6k9yhwahdvafnmn58qsk3ubnn6sheer' )
	brackets = response['pvp']['brackets'];

	twos = brackets['ARENA_BRACKET_2v2']['rating']
	threes = brackets['ARENA_BRACKET_3v3']['rating']
	rbgs = brackets['ARENA_BRACKET_RBG']['rating']

	event.send_message 'PvP Ratings for **' + name + '-' + realm + '**'
	event.send_message '2v2: ' + twos
	event.send_message '3v3: ' + threes
	event.send_message 'RBG: ' + rbgs
end

bot.command( :set, :description => 'Used to set specific settings on the bot.', :usage => '!set targetcaller <name>' ) do |event, setting, value|
	# Check for permissions as administrator
	case setting
		when 'targetcaller'
			tc = value
			event.send_message tc + ' has been set as priority speaker. Other users will be muted when in the same channel as ' + tc + '.'
			bot.send_message( 216234631538802688, 'Target Caller Updated.' )
		else
			event.send_message 'You may use the following options with !set:'
			event.send_message '!set targetcaller <discord name> - Sets the active Target Caller'
			event.send_message '!set welcome <the message>'
		end
end

bot.run :async

bot.send_message( 216234631538802688, 'Bot active.' )
bot.sync
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

bot = Discordrb::Commands::CommandBot.new token: 'MjE2MTkyNjUwMjM4MzYxNjAx.CpigoA.7yutKMWJraKvVXmmM3ppAWQaORQ', application_id: 216192650238361601, prefix: '!'

# ===============================================
# Default Ping response
# ===============================================
bot.command :ping do |event|
	event.respond 'pong'
end

# ===============================================
# Addons Out
# ===============================================
bot.command :addons do |event, type|
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
bot.command :guildmaster do |event|
	event.user.pm( 'The guildmaster is Lokien. His BattleTag is XtasyArmada#1751' )
end

# ===============================================
# Random Roll
# ===============================================
bot.command :roll do |event, min, max|
	rand( 1 .. 100 )
end

# ===============================================
# Realm Status
# ===============================================
bot.command :realmstatus do |event|
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
# Boss Master List
# ===============================================
bot.command :bosslist do |event, id|
	status = BattleNet.boss_master_list( 'q6k9yhwahdvafnmn58qsk3ubnn6sheer' )
	puts status
end

# ===============================================
# Boss Info
# ===============================================
bot.command :boss do |event, id|
	status = BattleNet.boss( id, 'q6k9yhwahdvafnmn58qsk3ubnn6sheer' )
	npcs = status['npcs']
	npcs.each do |boss|
		event.send_message boss['name']
	end
end

# ===============================================
# Action Dump
# ===============================================
bot.command :auction do |event, realm|
	event.respond 'Feature coming soon.'
	# auctions = BattleNet.auction_data_status( realm, 'q6k9yhwahdvafnmn58qsk3ubnn6sheer' )
	# puts auctions
end

# ===============================================
# Arena Ratings
# ===============================================
bot.command :ratings do |event, toon|	
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

bot.run

bot.send_message( 216234631538802688, 'Bot active.' )
bot.sync
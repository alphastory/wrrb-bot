require 'rubygems'
require 'httparty'

class BattleNet
	include HTTParty

	base_uri 'https://us.api.battle.net'

# ===================================================
# ACHIEVEMENT INFORMATION
# ===================================================
	# @@achievement
	# ===============================================
	# This provides data about an individual
	# achievement.
	# ===============================================
	def self.achievement( id, key )
		return get( '/wow/achievement/' + id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

# ===================================================
# AUCTION INFORMATION
# ===================================================
	# @@auction_data_status
	# ===============================================
	# Auction APIs currently provide rolling batches
	# of data about current auctions. Fetching
	# auction dumps is a two step process that
	# involves checking a per realm index file to
	# determine if a recent dump has been generated
	# and thenf etching the most recently generated
	# dump file if necessary.
	# ===============================================
	# This API resource provides a per-realm list of
	# recently generated auction house data dumps.
	# ===============================================
	def self.auction_data_status( realm, key )
		data = get( '/wow/auction/data/' + realm, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
		return get( data['files'][0]['url'] )
	end

# ===================================================
# BOSS INFORMATION
# ===================================================
	# @@boss_master_list
	# ===============================================
	# A list of all supported bosses. A 'boss' in
	# this context should be considered a boss
	# encounter, which may include more than one NPC.
	# ===============================================
	def self.boss_master_list( key )
		return get( '/wow/boss/', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@boss
	# ===============================================
	# The boss API provides information about bosses.
	# A 'boss' in this context should be considered a
	# boss encounter, which may include more than one
	# NPC.
	# ===============================================
	def self.boss( id, key )
		return get( '/wow/boss/' + id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

# ===================================================
# CHALLENGE MODE LEADERBOARDS
# ===================================================
	# The data in this request has data for all 9
	# challenge mode maps (currently). The map field
	# includes the current medal times for each
	# dungeon. Inside each ladder we provide data
	# about each character that was part of each run.
	# The character data includes the current cached
	# spec of the character while the member field
	# includes the spec of the character during the
	# challenge mode run.
	# ===============================================
	def self.realm_challenge_leaderboard( realm, key )
		return get( '/wow/challenge/' + realm, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@region_challenge_leaderboard
	# ===============================================
	# The region leaderboard has the exact same data
	# format as the realm leaderboards except there
	# is no realm field. It is simply the top 100
	# results gathered for each map for all of the
	# available realm leaderboards in a region.
	# ===============================================
	def self.region_challenge_leaderboard( realm, key )
		return get( '/wow/challenge/', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

# ===================================================
# CHARACTER INFORMATION
# ===================================================
	# @@character_profile
	# ===============================================
	# The Character Profile API is the primary way to
	# access character information. This Character
	# Profile API can be used to fetch a single
	# character at a time through an HTTP GET request
	# to a URL describing the character profile
	# resource. By default, a basic dataset will be
	# returned and with each request and zero or more
	# additional fields can be retrieved. To access
	# this API, craft a resource URL pointing to the
	# character who's information is to be retrieved.
	# ===============================================
	def self.character_profile( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_achievements
	# ===============================================
	# A map of achievement data including completion
	# timestamps and criteria information.
	# ===============================================
	def self.character_achievements( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'achievements',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_appearance
	# ===============================================
	# A map of a character's appearance settings such
	# as which face texture they've selected and
	# whether or not a healm is visible.
	# ===============================================
	def self.character_appearance( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'appearance',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_activity_feed
	# ===============================================
	# The activity feed of the character.
	# ===============================================
	def self.character_activity_feed( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'feed',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_guild
	# ===============================================
	# A summary of the guild that the character
	# belongs to. If the character does not belong to
	# a guild and this field is requested, this field
	# will not be exposed.
	# ===============================================
	# When a guild is requested, a map is returned
	# with key/value pairs that describe a basic set
	# of guild information. Note that the rank of the
	# character is not included in this block as it
	# describes a guild and not a membership of the
	# guild. To retrieve the character's rank within
	# the guild, you must specific a separate request
	# to the guild profile resource.
	# ===============================================
	def self.character_guild( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'guild',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_hunter_pets
	# ===============================================
	# A list of all of the combat pets obtained by
	# the character.
	# ===============================================
	def self.character_hunter_pets( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'hunterPets',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_items
	# ===============================================
	# A list of items equipped by the character. Use
	# of this field will also include the average
	# item level and average item level equipped for
	# the character.
	# ===============================================
	# When the items field is used, a map structure
	# is returned that contains information on the
	# equipped items of that character as well as the
	# average item level of the character.
	# ===============================================
	def self.character_items( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'items',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_mounts
	# ===============================================
	# A list of all of the mounts obtained by the
	# character.
	# ===============================================
	def self.character_mounts( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'mounts',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_pets
	# ===============================================
	# A list of the battle pets obtained by the
	# character.
	# ===============================================
	def self.character_pets( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'pets',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_pet_slots
	# ===============================================
	# Data about the current battle pet slots on this
	# characters account.
	# ===============================================
	# The pet slot contains which slot it is and
	# whether the slot is empty or locked. We also
	# include the battlePetId which is unique for
	# this character and can be used to match a
	# battlePetId in the pets field for this
	# character. The ability list is the list of 3
	# active abilities on that pet. If the pet is not
	# high enough level than it will always be the
	# first three abilities that the pet has.
	# ===============================================
	def self.character_pets( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'pets',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_professions
	# ===============================================
	# A list of the character's professions. Does not
	# include class professions.
	# ===============================================
	def self.character_professions( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'professions',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_progression
	# ===============================================
	# A list of raids and bosses indicating raid
	# progression and completeness.
	# ===============================================
	def self.character_progression( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'progression',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_pvp
	# ===============================================
	# A map of pvp information including arena team
	# membership and rated battlegrounds information.
	# ===============================================
	def self.character_pvp( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'pvp',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_completed_quests
	# ===============================================
	# A list of quests completed by the character.
	# ===============================================
	def self.character_completed_quests( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'quests',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_reputation
	# ===============================================
	# A list of the factions that the character has
	# an associated reputation with.
	# ===============================================
	def self.character_reputation( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'reputation',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_statistics
	# ===============================================
	# A map of character statistics.
	# ===============================================
	def self.character_statistics( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'statistics',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_attributes
	# ===============================================
	# A map of character attributes and stats.
	# ===============================================
	def self.character_attributes( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'stats',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_talents
	# ===============================================
	# A map of character attributes and stats.
	# ===============================================
	def self.character_talents( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'talents',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_titles
	# ===============================================
	# A list of the titles obtained by the character
	# including the currently selected title.
	# ===============================================
	def self.character_titles( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'titles',
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@character_audit
	# ===============================================
	# Raw character audit data that powers the
	# character audit on the game site.
	# ===============================================
	def self.character_audit( realm, character, key )
		return get( '/wow/character/' + realm + '/' + character, :query => {
			:fields => 'audit',
			:locale => 'en_US',
			:apikey => key
		} )
	end

# ===================================================
# GUILD INFORMATION
# ===================================================
	# @@guild_profile
	# ===============================================
	# The guild profile API is the primary way to
	# access guild information. This guild profile
	# API can be used to fetch a single guild at a
	# time through an HTTP GET request to a url
	# describing the guild profile resource. By
	# default, a basic dataset will be returned and
	# with each request and zero or more additional
	# fields can be retrieved.
	# ===============================================
	# There are no required query string parameters
	# when accessing this resource, although the 
	# fields query string parameter can optionally
	# be passed to indicate that one or more of the
	# optional datasets is to be retrieved. Those
	# additional fields are listed in the method
	# titled "Optional Fields".
	# ===============================================
	def self.guild_profile( realm, guildname, key )
		return get( '/wow/guild/' + realm + '/' + guildname, :query => {
			:locale => 'en_US',
			:fields => 'achievements,challenge',
			:apikey => key
		} )
	end

	# ===============================================
	# @@guild_members
	# ===============================================
	# A list of characters that are a member of the
	# guild. When the members list is requested, a
	# list of character objects is returned. Each
	# object in the returned members list contains a
	# character block as well as a rank field.
	# ===============================================
	def self.guild_profile( realm, guildname, key )
		return get( '/wow/guild/' + realm + '/' + guildname, :query => {
			:locale => 'en_US',
			:fields => 'members',
			:apikey => key
		} )
	end

	# ===============================================
	# @@guild_achievements
	# ===============================================
	# A set of data structures that describe the
	# achievements earned by the guild. When
	# requesting achievement data, several sets of
	# data will be returned.
	# ===============================================
	def self.guild_achievements( realm, guildname, key )
		return get( '/wow/guild/' + realm + '/' + guildname, :query => {
			:locale => 'en_US',
			:fields => 'achievements',
			:apikey => key
		} )
	end

	# ===============================================
	# @@guild_news
	# ===============================================
	# A set of data structures that describe the news
	# feed of the guild. When the news feed is
	# requested, you receive a list of news objects.
	# Each one has a type, a timestamp, and then some
	# other data depending on the type: itemId,
	# achievement object, etc.
	# ===============================================
	def self.guild_news( realm, guildname, key )
		return get( '/wow/guild/' + realm + '/' + guildname, :query => {
			:locale => 'en_US',
			:fields => 'news',
			:apikey => key
		} )
	end

	# ===============================================
	# @@guild_challenges
	# ===============================================
	# The top 3 challenge mode guild run times for
	# each challenge mode map.
	# ===============================================
	def self.guild_challenges( realm, guildname, key )
		return get( '/wow/guild/' + realm + '/' + guildname, :query => {
			:locale => 'en_US',
			:fields => 'challenge',
			:apikey => key
		} )
	end

# ===================================================
# ITEM INFORMATION
# ===================================================
	# @@item
	# ===============================================
	# The item API provides detailed item
	# information. This includes item set information
	# if this item is part of a set.
	# ===============================================
	def self.item( id, key )
		return get( '/wow/item/' + id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@item_set
	# ===============================================
	# The item API provides detailed item
	# information. This includes item set information
	# if this item is part of a set.
	# ===============================================
	def self.item_set( id, key )
		return get( '/wow/item/set/' + id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end


# ===================================================
# MOUNT INFORMATION
# ===================================================
	# @@mount_master_list
	# ===============================================
	# A list of all supported mounts.
	# ===============================================
	def self.mount_master_list( key )
		return get( '/wow/mount/', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end


# ===================================================
# PET INFORMATION
# ===================================================
	# @@pet_master_list
	# ===============================================
	# A list of all supported battle and vanity pets.
	# ===============================================
	def self.pet_master_list( key )
		return get( '/wow/pet/', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@pet_ability
	# ===============================================
	# This provides data about a individual battle
	# pet ability ID. We do not provide the tooltip
	# for the ability yet. We are working on a better
	# way to provide this since it depends on your
	# pet's species, level and quality rolls.
	# ===============================================
	def self.pet_ability( ability_id, key )
		return get( '/wow/pet/ability/' + ability_id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@pet_species
	# ===============================================
	# This provides the data about an individual pet
	# species. The species IDs can be found your
	# character profile using the options pets field.
	# Each species also has data about what it's 6
	# abilities are.
	# ===============================================
	def self.pet_species( species_id, key )
		return get( '/wow/pet/species/' + species_id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@pet_stats
	# ===============================================
	# Retrieve detailed information about a given
	# species of pet.
	# ===============================================
	def self.pet_stats( species_id, level, breed_id, quality_id, key )
		return get( '/wow/pet/stats/' + species_id, :query => {
			:locale => 'en_US',
			:level => level,
			:breedId => breed_id,
			:qualityId => quality_id,
			:apikey => key
		} )
	end

# ===================================================
# PVP INFORMATION
# ===================================================
	# @@bracket_leaderboard
	# ===============================================
	# The Leaderboard API endpoint provides
	# leaderboard information for the 2v2, 3v3, 5v5
	# and Rated Battleground leaderboards.
	# ===============================================
	def self.bracket_leaderboard( bracket, key )
		return get( '/wow/leaderboard/' + bracket, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

# ===================================================
# QUEST INFORMATION
# ===================================================
	# @@quest
	# ===============================================
	# Retrieve metadata for a given quest.
	# ===============================================
	def self.quest( quest_id, key )
		return get( '/wow/quest/' + quest_id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

# ===================================================
# REALM STATUS INFORMATION
# ===================================================
	# @@realm_status
	# ===============================================
	# Get the current status of all realms.
	# This returns a JSON object of ever realm.
	# ===============================================
	def self.realm_status( realms, key )
		r = ''
		if realms
			realms.each do |realm|
				r = r + ',' + realm
			end

			return get( '/wow/realm/status', :query => {
				:locale => 'en_US',
				:realms => r,
				:apikey => key
			} )
		else
			return get( '/wow/realm/status', :query => {
				:locale => 'en_US',
				:apikey => key
			} )
		end
	end

# ===================================================
# RECIPE INFORMATION
# ===================================================
	# @@recipe
	# ===============================================
	# The recipe API provides basic recipe
	# information.
	# ===============================================
	def self.recipe( recipe_id, key )
		return get( '/wow/recipe/' + recipe_id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

# ===================================================
# SPELL INFORMATION
# ===================================================
	# @@spell
	# ===============================================
	# The spell API provides some information about
	# spells.
	# ===============================================
	def self.spell( spell_id, key )
		return get( '/wow/spell/' + spell_id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

# ===================================================
# INSTANCE INFORMATION
# ===================================================
	# @@instance_master_list
	# ===============================================
	# A list of all supported zones and their bosses.
	# A 'zone' in this context should be considered
	# a dungeon, or a raid, not a zone as in a world
	# zone. A 'boss' in this context should be
	# considered a boss encounter, which may include
	# more than one NPC.
	# ===============================================
	def self.instance_master_list( key )
		return get( '/wow/zone/', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@instance
	# ===============================================
	# The Zone API provides some information about
	# zones.
	# ===============================================
	def self.instance( instance_id, key )
		return get( '/wow/zone/' + instance_id, :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

# ===================================================
# DATA SOURCES
# ===================================================
	# @@battlegroups
	# ===============================================
	# The battlegroups data API provides the list of
	# battlegroups for this region. Please note the
	# trailing / on this URL.
	# ===============================================
	def self.battlegroups( key )
		return get( '/wow/data/battlegroups/', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@races
	# ===============================================
	# The character races data API provides a list of
	# each race and their associated faction, name,
	# unique ID, and skin.
	# ===============================================
	def self.races( key )
		return get( '/wow/data/character/races', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@classes
	# ===============================================
	# The character classes data API provides a list
	# of character classes.
	# ===============================================
	def self.classes( key )
		return get( '/wow/data/character/classes', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@achievements
	# ===============================================
	# The character achievements data API provides a
	# list of all of the achievements that characters
	# can earn as well as the category structure and
	# hierarchy.
	# ===============================================
	def self.achievements( key )
		return get( '/wow/data/character/achievements', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@all_guild_rewards
	# ===============================================
	# The guild rewards data API provides a list of
	# all guild rewards.
	# ===============================================
	def self.all_guild_rewards( key )
		return get( '/wow/data/guild/rewards', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@all_guild_perks
	# ===============================================
	# The guild perks data API provides a list of all
	# guild perks.
	# ===============================================
	def self.all_guild_perks( key )
		return get( '/wow/data/guild/perks', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@all_guild_achievements
	# ===============================================
	# The guild achievements data API provides a list
	# of all of the achievements that guilds can earn
	# as well as the category structure and hierarchy.
	# ===============================================
	def self.all_guild_perks( key )
		return get( '/wow/data/guild/achievements', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@item_classes
	# ===============================================
	# The item classes data API provides a list of
	# item classes
	# ===============================================
	def self.item_classes( key )
		return get( '/wow/data/item/classes', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@all_talents
	# ===============================================
	# The talents data API provides a list of talents,
	# specs and glyphs for each class.
	# ===============================================
	def self.all_talents( key )
		return get( '/wow/data/talents', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end

	# ===============================================
	# @@pet_types
	# ===============================================
	# The different battle pet types (including what
	# they are strong and weak against)
	# ===============================================
	def self.pet_types( key )
		return get( '/wow/data/pet/types', :query => {
			:locale => 'en_US',
			:apikey => key
		} )
	end


end


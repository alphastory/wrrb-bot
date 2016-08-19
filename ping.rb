require 'rubygems'
require 'discordrb'

bot = Discordrb::Bot.new token: 'MjE2MTkyNjUwMjM4MzYxNjAx.CpigoA.7yutKMWJraKvVXmmM3ppAWQaORQ', application_id: 216192650238361601

bot.message( with_text: '~ping' ) do |event|
	event.respond 'Pong!'
end

bot.run
#!/usr/bin/ruby
require 'soundcloud'
require 'optparse'
require 'yaml'


client = SoundCloud.new({
  :client_id     => '28b83fea1a52549bb1f467dc75bbc0ac',
  :client_secret => 'd4cadd327086e39be60a5bd49c73683f'
#  :refresh_token => SOME_REFRESH_TOKEN
})

# upload a new track with audio.mp3 as audio and image.jpg as artwork
mp3 = ''
title = ''
description = ''
tags = ''


options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: upload.rb [options]"

  opts.on('-mp3', '--mp3 filename', 'MP3 Filename') { |v| options[:mp3] = v }
  opts.on('-title', '--title Title', 'Title') { |v| options[:title] = v }
  opts.on('-description', '--description DESCRIPTION', 'Description') { |v| options[:description] = v }
  opts.on('-tags', '--tags PORT', 'Tags') { |v| options[:tags] = v }
end.parse!

dest_options = YAML.load_file('destination_config.yaml')
puts dest_options['dest_name']

######

name = gets

track = client.post('/tracks', :track => {
  :title      => 'a new track',
  :asset_data => File.new('audio.mp3')
})

# print new tracks link
puts track.permalink_url

# fetch a track by it's ID
track = client.get('/tracks/13198684')

# update the track's metadata
client.put(track.uri, :track => {
  :description => 'This track was recorded in Berlin',
  :genre => 'Electronic',
  :artwork_data => File.new('artwork.jpg', 'rb')
})

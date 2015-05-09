#!/usr/bin/ruby

require 'soundcloud'

client = Soundcloud.new({
  :client_id     => ''
})
# get 10 hottest tracks
tracks = client.get('/tracks', :limit => 10, :order => 'hotness')
# print each link
tracks.each do |track|
  puts track.permalink_url
end

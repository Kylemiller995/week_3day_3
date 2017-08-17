require('pry')
require_relative('../models/albums.rb')
require_relative('../models/artists.rb')

Artists.delete_all()
Albums.delete_all()

artist1 = Artists.new({'name' => 'beyonce'})
artist2 = Artists.new({'name' => 'mr. one time for my l.a. sisters one time for my l.a. hoes'})
artist1.save()
artist2.save()

album1 = Albums.new({
  'artist_id' => artist1.id,
  'genre' => 'rap',
  'title' => 'forest hill drive'
  })

  album1.save()

  album2 = Albums.new({
    'artist_id' => artist2.id,
    'genre' => 'rnb',
    'title' => 'beyonce'
    })

    album2.save()

binding.pry
nil

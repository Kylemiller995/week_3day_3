require_relative('../db/sql_runner')

class Albums

  attr_accessor(:genre, :title)
  attr_reader(:id, :artist_id)

  def initialize(album_details)
    @artist_id = album_details['artist_id']
    @genre = album_details['genre']
    @title = album_details['title']
    @id = album_details['id'].to_i() if album_details['id']
  end

  def artist
    sql = '
    SELECT * FROM artists
    WHERE id = $1;'
    result_array = SqlRunner.run(sql, [@artist_id])
    artist_hash = result_hash[0]
    artist_object = Artists.new(artist_hash)
    return artist_object
  end

  def save()
    sql = '
      INSERT INTO albums(
      artist_id,
      genre,
      title

      ) VALUES (
        $1, $2, $3
      )
      RETURNING id;
    '
    values = [@artist_id, @genre, @title,]
    results_array = SqlRunner.run(sql, values)

    saved_order_hash = results_array[0]
    @id = saved_order_hash['id'].to_i()
  end

  def update()
    db = PG.connect({dbname: 'music_manager', host: 'localhost'})
    sql = '
    UPDATE albums SET(
      artist_id,
      genre,
      title
    ) = (
      $1, $2, $3
    )
    WHERE id = $4'

    values = [@artist_id, @genre, @title]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM albums WHERE id = $1'
    SqlRunner.run(sql, [@id])
  end

  def Albums.delete_all
    sql = 'DELETE FROM albums;'
    SqlRunner.run(sql)
  end

  def Albums.all()
    sql = 'SELECT * FROM albums'
    orders = SqlRunner.run(sql)
    return orders.map {|order_hash| Albums.new(order_hash)}
  end

  def self.find()
    sql = "SELECT FROM bounty_board
    WHERE title = $1;"
  end



end

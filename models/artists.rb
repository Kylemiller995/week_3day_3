require_relative('../db/sql_runner')

class Artists

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(params)
    @id = params['id'].to_i() if params['id']
    @name = params['name']
  end

  def albums
    sql ='
      SELECT * FROM albums
      WHERE customer_id = $1;
    '
    order_hashes = SqlRunner.run(sql, [@id])
    albums = order_hashes.map{|order_hash|}
  end


  def Artists.all
    sql = 'SELECT * FROM arists;'
    results = SqlRunner.run(sql)
    artists = results.map{|artists| Artists.new(result_hash)}
    return customers
  end

  def save
    sql = '
      INSERT INTO artists(
      name
      )VALUES(
        $1
      )
      RETURNING *'
    returned_data = SqlRunner.run(sql, [@name])
    @id = returned_data[0]['id'].to_i()
  end

  def Artists.delete_all
    sql = 'DELETE FROM artists;'
    SqlRunner.run(sql)
  end

end

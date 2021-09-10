def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.

  Movie
    .select(:id, :title, :yr, :score)
    .where(yr: 1980..1989, score: 3..5 )
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  # a = Movie.find_by_sql(<<-SQL)
  #   SELECT
  #     yr
  #   FROM
  #     movies
  #   GROUP BY
  #     yr
  #   HAVING
  #     yr NOT IN (
  #       SELECT
  #         yr
  #       FROM
  #         movies
  #       WHERE
  #         score > 8
  #     )
  # SQL
  # a.pluck(:yr) 

  Movie
    .group(:yr)
    .having('MAX(score) < 8')
    .pluck(:yr)
  end



def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Movie
    .select('actors.id, actors.name')
    .joins(:actors)
    .order('castings.ord ASC')
    .where(title: title)

  # Actor
  #   .select(:id, :name)
  #   .joins(:movies)
  #   .where(movies: {title: title})
  #   .order('castings.ord ASC')
end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie 
    .select('movies.id, movies.title, actors.name') # actors.name??
    .joins(:actors)
    .where('castings.ord = 1 AND movies.director_id = castings.actor_id') #quotes allows and?
    

end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.

end

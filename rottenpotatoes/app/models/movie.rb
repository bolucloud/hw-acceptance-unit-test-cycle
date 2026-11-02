class Movie < ActiveRecord::Base
  def others_by_same_director
    return Movie.none if director.blank?
    Movie.where(director: director).where.not(id: id)
  end
end

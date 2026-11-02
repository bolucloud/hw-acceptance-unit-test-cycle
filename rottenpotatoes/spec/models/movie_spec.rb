require 'rails_helper'

RSpec.describe Movie, type: :model do
  before(:all) do
    if Movie.where(:title => "Big Hero 6").empty?
      Movie.create(:title => "Big Hero 6",
                   :rating => "PG", :release_date => "2014-11-07")
    end

    # TODO(student): add more movies to use for testing
  end

  describe "others_by_same_director method" do
    it "returns all other movies by the same director" do
      movie = Movie.create(
        title: "Bolus test world", 
        rating: "PG", 
        release_date: "2024-08-19",
        director: "Bolu"
      )

      second_movie = Movie.create(
        title: "Bolus test second world",
        rating: "PG", 
        release_date: "2023-10-03",
        director: "Bolu"
      )

      third_movie = Movie.create(
        title: "Bolus test third world", 
        rating: "PG", 
        release_date: "2022-05-15",
        director: "Sean Penn"
      )
      expect(movie.others_by_same_director).to match_array([second_movie])
    ensure
      Movie.where(id: [movie.id, second_movie.id, third_movie.id]).destroy_all
    end

    it "does not return movies by other directors" do
      movie = Movie.create(
          title: "Movie with random director", 
          rating: "PG", 
          release_date: "2024-08-19",
          director: "Bolu"
      )
      other_movie = Movie.create(
          title: "Movie with another director", 
          rating: "PG", 
          release_date: "2023-03-19",
          director: "Another Bolu"
      )
      expect(movie.others_by_same_director).not_to include(other_movie)
    ensure
      Movie.where(id: [movie.id, other_movie.id]).destroy_all
    end

    it "gives no movies where there's no director info" do
      movie = Movie.create(
          title: "NilDirector Movie", 
          rating: "PG", 
          release_date: "2011-01-11",
          director: nil
      )
      expect(movie.others_by_same_director).to be_empty
    ensure
      movie.destroy
    end
  end
end



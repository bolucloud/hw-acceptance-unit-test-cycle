# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before(:all) do
    Movie.destroy_all

    Movie.create(title: 'Big Hero 6',
                 rating: 'PG',
                 release_date: '2014-11-07',
                 director: 'Don Hall, Chris Williams')

    # TODO(student): add more movies to use for testing
  end

  describe 'when trying to find movies by the same director' do
    it 'returns a valid collection when a valid director is present' do
      # TODO(student): implement this test
      movie = Movie.create(
        title: 'Bolus world',
        rating: 'PG',
        release_date: '2024-08-19',
        director: 'Bolu'
      )

      second_movie = Movie.create(
        title: 'Bolus second world',
        rating: 'PG',
        release_date: '2023-10-03',
        director: 'Bolu'
      )

      third_movie = Movie.create(
        title: 'Bolus third world',
        rating: 'PG',
        release_date: '2022-05-15',
        director: 'Sean Penn'
      )

      get :similar, params: { id: movie.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:movies)).to contain_exactly(second_movie)
    ensure
      Movie.where(id: [movie.id, second_movie.id, third_movie.id]).destroy_all
    end

    it 'redirects to index with a warning when no director is present' do
      movie = Movie.create!(
        title: 'Bolus world',
        rating: 'PG',
        release_date: '2024-08-19',
        director: nil
      )
      get :similar, params: { id: movie.id }
      expect(response).to redirect_to(movies_path)
      expect(flash[:notice]).to match(/has no director information/)
    ensure
      movie.destroy
    end
  end

  describe 'creates' do
    it 'movies with valid parameters' do
      get :create, params: { movie: { title: 'Threenagers', director: 'The Prof.s Ritchey',
                                      rating: 'G', release_date: '2015-01-20' } }
      expect(response).to redirect_to movies_path
      expect(flash[:notice]).to match(/Threenagers was successfully created./)
      Movie.find_by(title: 'Threenagers').destroy
    end
  end

  describe 'updates' do
    it 'redirects to the movie details page and flashes a notice' do
      movie = Movie.create(title: 'Attack of the Munchkins', director: 'Sofia Grace',
                           rating: 'PG', release_date: '2024-08-19')
      get :update, params: {
        id: movie.id,
        movie: {
          description: 'A whimsical and adventurous film where a small town is unexpectedly '\
          'overrun by mischievous, pint-sized creatures known as Munchkins. As the townspeople ' \
          'scramble to defend their homes and livelihoods, they uncover the Munchkins\' origins ' \
          'and intentions. With humor and heart, the community bands together, discovering ' \
          'hidden strengths and forging new friendships along the way. The movie blends comedy, ' \
          'action, and a touch of fantasy, offering a light-hearted yet thrilling experience ' \
          'for audiences of all ages.'
        }
      }

      expect(response).to redirect_to movie_path(movie)
      expect(flash[:notice]).to match(/Attack of the Munchkins was successfully updated./)
      movie.destroy
    end

    it 'actually does the update' do
      movie = Movie.create(title: 'Seven Samurai', director: 'Yasujiro Ozu',
                           rating: 'PG', release_date: '1954-04-26')
      get :update, params: { id: movie.id, movie: { director: 'Akira Kurosawa' } }

      expect(assigns(:movie).director).to eq('Akira Kurosawa')
      movie.destroy
    end
  end

  describe 'movie pages' do
    it 'shows movie index page' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'shows movie details page' do
      movie = Movie.create(
        title: 'Bolus second world',
        rating: 'PG',
        release_date: '2023-10-03',
        director: 'Bolu'
      )
      get :show, params: { id: movie.id }
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    ensure
      movie.destroy
    end

    it 'shows the movie edit form' do
      movie = Movie.create(
        title: 'Bolus second world',
        rating: 'PG',
        release_date: '2021-10-03',
        director: 'Bolu'
      )
      get :edit, params: { id: movie.id }
      expect(response).to render_template(:edit)
      expect(assigns(:movie)).to eq(movie)
    ensure
      movie.destroy
    end

    it 'deletes a movie' do
      movie = Movie.create(
        title: 'Bolus second world',
        rating: 'PG',
        release_date: '2021-10-03',
        director: 'Bolu'
      )
      expect do
        delete :destroy, params: { id: movie.id }
      end.to change(Movie, :count).by(-1)
      expect(response).to redirect_to(movies_path)
      expect(flash[:notice]).to match(/Movie 'Bolus second world' deleted./)
    ensure
      movie.destroy
    end
  end
end

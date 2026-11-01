
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

When('I go to the edit page for {string}') do |title|
  visit edit_movie_path(Movie.find_by!(title: title))
  #pending # Write code here that turns the phrase above into concrete actions
end

When('I fill in {string} with {string}') do |field, value|
  fill_in(field, with: value)
  #pending # Write code here that turns the phrase above into concrete actions
end

When('I press {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the director of {string} should be {string}') do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I am on the details page for {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I follow {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should be on the Similar Movies page for {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should not see {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should be on the home page') do
  pending # Write code here that turns the phrase above into concrete actions
end
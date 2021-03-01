# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  first = (/#{e1}/ =~ page.body)
  second = (/#{e2}/ =~ page.body)
  first.should <= second
  
  # fail "Unimplemented"
end

When /^I press "(.*)" button/ do |button|
  click_button button
end

# Then /I should (not )?see the following movies: (.*)$/ do |present, movies_list|
#   movies = movies_list.split(', ')
#   movies.each do |movie|
#     if present.nil?
#       expect(page).to have_content(movie)
#     else
#       expect(page).not_to have_content(movie)
#     end
#   end
# end

Then /^I should see : (.*)/ do |movies|
  movies_a = movies.split( "," )
  movies_a.each do |movie|
    m = movie.strip
    step( "I should see #{m}" )
  end
end

Then /^I should not see : (.*)/ do |movies|
  movies_a = movies.split( "," )
  movies_a.each do |movie|
    m = movie.strip
    step( "I should not see #{m}" )
  end
end
# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  ratings = rating_list.split(", ")
  
  ratings.each do |r|
    if(uncheck == 'un')
      uncheck("ratings_#{r}")
    else
      check("ratings_#{r}")
    end
  end
  
  # fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = Movie.count
  rows.should == 10
  # fail "Unimplemented"
end

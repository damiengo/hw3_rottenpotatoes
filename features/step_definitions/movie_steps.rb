# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert (page.body.index(e1) < page.body.index(e2))
end

Then /I should see all of the movies/ do
  assert_equal find("#movies").find("tbody").all("tr").size, Movie.all.size
end

Then /I should not see any movie/ do
  assert_equal find("#movies").find("tbody").all("tr").size, 0
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each do |rating|
    if(uncheck == 'un')
      uncheck("ratings_"+rating.strip)
    else
      check("ratings_"+rating.strip)
    end
  end
end

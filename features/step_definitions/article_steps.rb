Given /^I have articles titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Article.create!(:title => title)
  end
end

When /^I go to the list articles$/ do
  visit articles_path
end

Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content(text)
end

Given(/^I have no articles$/) do
  Article.delete_all
end

Given(/^I am on the list of articles$/) do
  visit articles_path
end

When(/^I follow "(.*?)"$/) do |arg1|
  click_link arg1
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in arg1, :with => arg2
end

When(/^I press "(.*?)"$/) do |arg1|
  click_button(arg1)
end

Then /^I should have ([0-9]+) article$/ do |count|
  expect(Article.count).to eq(count.to_i)
end


# Given(/^I send and accept JSON$/) do
#   header 'Accept', 'application/json'
#   header 'Content-Type', 'application/json'
# end

# When(/^I send a GET request for "(.*?)"$/) do |arg1|
#   get arg1
# end

Then(/^the response should be "(.*?)"$/) do |status|
  expect(last_response.status).to eq(status.to_i)
end

Then(/^the JSON response should be an array with (\d+) "(.*?)" elements$/) do |number_of_children, name|
  page = JSON.parse(last_response.body)
  
  expect(page.map { |d| d[name] }.length).to eq(number_of_children.to_i)

end

# When(/^I send a POST request to "(.*?)" with the following:$/) do |path, body|
#   post path, body
# end

Then(/^the JSON response should be "(.*?)" element$/) do |name|
  # page = JSON.parse(last_response.body)

  # expect(page.map { |d| d[0]}).to eq(name)

  json    = JSON.parse(last_response.body)
  result = JsonPath.new('$.content').on(json)
  expect(result[0]).to eq("Conteudo")
end


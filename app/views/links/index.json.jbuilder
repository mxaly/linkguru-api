json.links(links) do |link|
  json.url link.url
  json.description link.description
  json.score link.score
  json.user_name = link.user.name
end

json.links(links) do |link|
  json.url link.url
  json.description link.description
  json.rating link.rating
  json.user_name = link.user.name
end

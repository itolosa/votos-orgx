json.array!(@fronts) do |front|
  json.extract! front, :id
  json.url front_url(front, format: :json)
end

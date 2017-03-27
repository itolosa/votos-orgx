json.array!(@activist_fronts) do |activist_front|
  json.extract! activist_front, :id
  json.url activist_front_url(activist_front, format: :json)
end

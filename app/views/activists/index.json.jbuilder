json.array!(@activists) do |activist|
  json.extract! activist, :id
  json.url activist_url(activist, format: :json)
end

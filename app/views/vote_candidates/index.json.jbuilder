json.array!(@vote_candidates) do |vote_candidate|
  json.extract! vote_candidate, :id, :candidate_id, :vote_id
  json.url vote_candidate_url(vote_candidate, format: :json)
end

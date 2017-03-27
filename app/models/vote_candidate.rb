class VoteCandidate < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :vote
  accepts_nested_attributes_for :candidate
end

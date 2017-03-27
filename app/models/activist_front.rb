class ActivistFront < ActiveRecord::Base
  belongs_to :activist
  belongs_to :front
end

class Front < ActiveRecord::Base
  has_many :activist_fronts, dependent: :destroy
  has_many :activists, through: :activist_fronts

  before_save :format_fields

  def format_fields
    self.name = self.name.strip.titleize
  end

  def show_vote_ratio
    "#{self.activists.count(:vote_id)}/#{self.activists.count}"
  end

  def vote_percent
    (self.activists.count(:vote_id).to_f/self.activists.count)*100
  end
end

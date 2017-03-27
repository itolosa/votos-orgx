class Section < ActiveRecord::Base
  has_many :activists, dependent: :destroy

  before_save :format_fields

  def format_fields
    self.name = self.name.strip.titleize
  end

  def show_vote_ratio
    "#{self.activists.count(:vote_id)}/#{self.activists.count}"
  end

  def vote_percent
    (self.activists.count(:vote_id).to_f/self.activists.count).round(2)*100
  end

  def factor
    n = self.activists.count(:vote_id)
    Math.sqrt(n)
  end

  def factor_pp
    n = self.activists.count(:vote_id)
    Math.sqrt(n)/n
  end
end

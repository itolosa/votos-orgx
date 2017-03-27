class Candidate < ActiveRecord::Base
  has_many :vote_candidates, dependent: :destroy
  has_many :votes, through: :vote_candidates

  before_save :format_fields

  def format_fields
    self.name = self.name.strip.titleize
  end

  def score
    @score ||= calc_score
  end

  def presentation_filename(extension = "docx")
    filename = ActiveSupport::Inflector.transliterate(self.name).downcase.split.join('_')
    "#{filename}.#{extension}"
  end

  def total_score
    factors = 0.0
    Section.all.each do |section|
      nact = section.activists.count(:vote_id)
      factors += Math.sqrt(nact)
    end
    factors
  end

  def vote_percent
    ((score/total_score)*100)
  end

  def calc_score
    sum = 0
    Section.all.each do |section|
      p = Math.sqrt(section.activists.count(:vote_id))/section.activists.count(:vote_id)
      sum += p*votes.joins(:activist).where('section_id = ? AND activists.vote_id IS NOT NULL', section).count
    end
    return sum
  end

  def selected
    false
  end
end

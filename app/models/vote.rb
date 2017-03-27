class Vote < ActiveRecord::Base
  has_one :activist, dependent: :nullify
  has_many :vote_candidates, dependent: :destroy
  has_many :candidates, through: :vote_candidates
  accepts_nested_attributes_for :vote_candidates
  accepts_nested_attributes_for :candidates


  #attr_writter :current_step

  def set_current_step(step)
    @current_step = step
  end

  def steps
    %w[form confirmation]
  end

  def current_step
    @current_step || steps.first
  end

  def next_step
    self.set_current_step(steps[steps.index(current_step)+1])
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end
end

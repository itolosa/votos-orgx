class HomePolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

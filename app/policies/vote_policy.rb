class VotePolicy < ApplicationPolicy
  
  def initialize(user, record)
    unless user
      raise Pundit::NotAuthorizedError, "must be logged in"
    end
    @user = user
    @record = record
  end

  def index?
    false
  end

  def create?
    true
  end

  def confirm?
    true
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    false
  end

  def edit?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

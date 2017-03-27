class CandidatePolicy < ApplicationPolicy

  def index?
    user and user.has_role?(:admin)
  end

  def show?
    user and user.has_role?(:admin)
  end

  def edit?
    user and user.has_role?(:admin)
  end

  def update?
    user and user.has_role?(:admin)
  end

  def destroy?
    user and user.has_role?(:admin)
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end

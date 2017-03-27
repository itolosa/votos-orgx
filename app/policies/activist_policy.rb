class ActivistPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def login_from_token?
    true
  end

  def index?
    user and user.has_role?(:admin)
  end

  def show?
    user and user.has_role?(:admin)
  end

  def new?
    user and user.has_role?(:admin)
  end

  def delete?
    user and user.has_role?(:admin)
  end

  def create?
    user and user.has_role?(:admin)
  end

  def edit?
    user and user.has_role?(:admin)
  end

  def update?
    user and user.has_role?(:admin)
  end

  def send_mail?
    user and user.has_role?(:admin)
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end

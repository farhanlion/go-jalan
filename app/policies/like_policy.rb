class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    false
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    !user.nil?
  end

  def edit?
    update?
  end

  def update?
    false
  end

  def destroy?
    record.user == user && @like != 'anything'
  end
end

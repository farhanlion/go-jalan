class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

    def index?
      true
    end

    def show?
      true
    end

    def new?
      # All users can type new review
      true
    end

    def create?
      # User must be logged in to create a review
      !user.nil?
    end

    def edit?
      update?
    end

    def update?
      record.user == user
    end

    def destroy?
      record.user == user
    end
end

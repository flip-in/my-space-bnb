class BookingPolicy < ApplicationPolicy
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

  def create?
    true
  end

  def new?
    true
  end

  def update?
    true
  end

  def edit?
    true
  end

  def destroy?
    true
  end

  def accept?
    true
  end

  def reject?
    true
  end

  def pending?
    true
  end
end

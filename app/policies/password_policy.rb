class PasswordPolicy < ApplicationPolicy
  def index?
    user.admin? if user
  end

  def update?
    user.admin?  if user
  end

  def destroy?
    user.admin?  if user
  end

  def edit?
    user.admin? if user
  end

  def new?
    user.admin? if user
  end

  def show?
    user.admin? or (user.id == record.id) if user
  end

  def import?
    user.admin? if user
  end

end

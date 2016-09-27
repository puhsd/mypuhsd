class UploadPolicy < ApplicationPolicy
  def index?
    user.admin? if user
  end

  def update?
    user.admin? if user
  end

  def destroy?
    user.admin? if user
  end

  def edit?
    user.admin? if user
  end

  def new?
    user.admin? if user
  end

  def create?
    new?
  end

  def show?
    user.admin? if user
  end

  def rerun?
    user.admin? if user
  end

  def download?
    user.admin? if user
  end

end

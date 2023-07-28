# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record, :error_message

  def initialize(user, record, error_message: "You do not have permissions to perform this action.")
    @user = user
    @record = record
    @error_message = error_message
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  private

  attr_writer :error_message

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end

class RoomTicketPolicy < ApplicationPolicy
  def index?
    is_admin?
  end

  def show?
    is_admin?
  end

  def create?
    is_rover?
  end

  def new?
    create?
  end

  def update?
    is_admin?
  end
  
  def edit?
    update?
  end

  def destroy?
    is_admin?
  end

  def send_email_for_tdx_ticket?
    is_rover? || is_admin?
  end
end

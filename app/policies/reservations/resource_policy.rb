module Reservations
  class ResourcePolicy < ApplicationPolicy
    alias_method :resource, :record

    class Scope < Scope
      def resolve
        # Only show visible resources unless admin.
        scope_with_visibility = active_admin? ? scope : scope.visible

        # Need to load the resources because access_level is computed by RuleSet which can't be computed
        # at database level.
        ids = scope_with_visibility.select do |resource|
          sample_reservation = Reservation.new(reserver: user, resource: resource)
          sample_reservation.access_level != "forbidden"
        end.map(&:id)
        scope.where(id: ids)
      end
    end

    def index?
      active_admin?
    end

    def show?
      active_admin?
    end

    def create?
      active_admin?
    end

    def update?
      active_admin?
    end

    def destroy?
      active_admin?
    end

    def permitted_attributes
      [:default_calendar_view, :guidelines, :hidden, :meal_abbrv, :name,
        :photo, :photo_tmp_id, :photo_destroy]
    end
  end
end

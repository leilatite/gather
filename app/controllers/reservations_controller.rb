class ReservationsController < ApplicationController
  def index
    authorize Reservation::Reservation

    # JSON list of reservations for calendar plugin
    if request.xhr?
      @reservations = policy_scope(Reservation::Reservation).
        where(resource_id: params[:resource_id]).
        where("starts_at < ? AND ends_at > ?",
          Time.zone.parse(params[:end]), Time.zone.parse(params[:start]))
      render json: @reservations

    # Main reservation pages
    else
      # This will happen in JSON mode.
      # We don't actually return any Reservations here.
      skip_policy_scope

      @community = params[:community] ? Community.find_by_abbrv(params[:community]) : current_user.community
      return render nothing: true, status: 404 unless @community

      if params[:resource_id]
        @resource = Reservation::Resource.find(params[:resource_id])
        @other_resources = Reservation::Resource.where(community_id: @community.id).
          where("id != ?", @resource.id)
        @other_communities = Community.where("id != ?", @community.id)
        render("calendar")
      else
        @communities = Community.by_name.all
        @resources = Reservation::Resource.where(community_id: @community.id)
        render("home")
      end
    end
  end

  def show
    @reservation = Reservation::Reservation.find(params[:id])
    authorize @reservation
    @resource = @reservation.resource
  end

  def new
    @resource = Reservation::Resource.find_by(id: params[:resource_id])
    raise "Resource not found" unless @resource

    @reservation = Reservation::Reservation.new_with_defaults(resource: @resource, reserver: current_user)
    authorize @reservation
    prep_form_vars
  end

  def edit
    @reservation = Reservation::Reservation.find(params[:id])
    authorize @reservation
    @reservation.guidelines_ok = "1"
    @resource = @reservation.resource
    prep_form_vars
  end

  def create
    @reservation = Reservation::Reservation.new(reserver: current_user)
    authorize @reservation
    @reservation.assign_attributes(reservation_params)
    if @reservation.save
      flash[:success] = "Reservation created successfully."
      redirect_to reservations_path
    else
      @resource = @reservation.resource
      prep_form_vars
      set_validation_error_notice
      render :new
    end
  end

  def update
    @reservation = Reservation::Reservation.find(params[:id])
    authorize @reservation
    if @reservation.update_attributes(reservation_params)
      flash[:success] = "Reservation updated successfully."
      redirect_to reservations_path
    else
      @resource = @reservation.resource
      prep_form_vars
      set_validation_error_notice
      render :edit
    end
  end

  def destroy
    @reservation = Reservation::Reservation.find(params[:id])
    authorize @reservation
    @reservation.destroy
    flash[:success] = "Reservation deleted successfully."
    redirect_to(reservations_path_for_resource(@reservation.resource))
  end

  private

  def prep_form_vars
    @kinds = @resource.kinds # May be nil
  end

  # Pundit built-in helper doesn't work due to namespacing
  def reservation_params
    params.require(:reservation_reservation).permit(policy(@reservation).permitted_attributes)
  end
end
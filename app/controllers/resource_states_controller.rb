class ResourceStatesController < ApplicationController
  before_action :auth_user
  before_action :set_room, only: %i[ new create ]

  # GET /resource_states/new
  def new
    authorize ResourceState

    # @room = Room.find(params[:room_id])

    # if params[:room_state_id].present?
    #   @room_state_id = params[:room_state_id].to_i
    # end

    room_state = @room.room_state_for_today

    resources_ids = Resource.where(room_id: @room).ids

    @resource_states = @room.resources.all.map do |resource|
      room_state.resource_states.new(resource: resource)
    end
    # @room = Room.find(params[:room_id])
    # 
    # authorize @resources
    # #defaults to /resource_states
    # @resource_state = ResourceState.new
  end

  # POST /resource_states or /resource_states.json
  def create
    authorize ResourceState

    @room_state = @room.room_state_for_today
    @resource_states = resource_state_params.map do |res_params|
      @room_state.resource_states.new(res_params)
    end

    ActiveRecord::Base.transaction do
      @resource_states.each do |res|
        raise ActiveRecord::Rollback unless res.save
      end
    end

    if @common_attribute_states.all?(&:persisted?)
      redirect_to room_path(@room), notice: 'Resources States were successfully saved.'
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def set_room
    @room = Room.find_by(id: params[:room_id])

    unless @room
      redirect_to rooms_path, alert: 'Room doesnt exist.' and return
    end

    room_state = @room.room_state_for_today
    if room_state.nil?
      redirect_to room_path(@room), alert: 'Complete previous steps for Room.'
    elsif room_state.resource_states.any?
      redirect_to room_path(@room), alert: 'Already saved Common Attribute States for this Room today.'
    end

  end

  # Only allow a list of trusted parameters through.
  def resource_state_params

    params.require(:resource_state).permit(:room_state_id, :is_checked, :resource_id)
    end
  end


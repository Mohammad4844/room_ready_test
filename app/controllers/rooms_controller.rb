class RoomsController < ApplicationController
  before_action :auth_user
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
    @rooms_page_announcement = Announcement.find_by(location: "rooms_page")
    authorize @rooms
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @common_attributes = CommonAttribute.all
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @building = Building.find(params[:building_id])
    @floor = Floor.find(params[:floor_id])
    authorize @room
  end

  # GET /rooms/1/edit
  def edit
    session[:return_to] = request.referer
    @floors = @room.floor.building.floors.pluck(:name, :id)
  end

  # POST /rooms or /rooms.json
  def create
    @building = Building.find(params[:building_id])
    @floor = Floor.find(params[:floor_id])
    @room = Room.new(room_params)
    @room.floor_id = params[:floor_id]
    authorize @room
    respond_to do |format|
      if @room.save
        fail
        format.html { redirect_to building_path(@building), notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        fail
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    if @room.update(room_params)
      redirect_back_or_default(notice: "The room was updated.", alert: false)
    else
      @floors = @room.floor.building.floors.pluck(:name, :id)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy!

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])

      authorize @room
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:rmrecnbr, :room_number, :room_type, :facility_id, :floor_id)
    end
end

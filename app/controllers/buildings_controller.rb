class BuildingsController < ApplicationController
  before_action :auth_user
  before_action :set_building, only: %i[ show edit update destroy ]
  before_action :set_zone_id, only: %i[index new edit]

  # GET /buildings or /buildings.json
  def index
    @buildings = Building.where(zone_id: @zone_id)
    @zone_name = Zone.find(@zone_id).name
    authorize @buildings
  end

  # GET /buildings/1 or /buildings/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @building }
    end
  end

  # GET /buildings/new
  def new
    @building = Building.new()
    authorize @building
  end

  # GET /buildings/1/edit
  def edit
  end

  # POST /buildings or /buildings.json
  def create
    @building_params = building_params
    @zone_id = @building_params[:zone_id]
    @building = Building.find_or_initialize_by(bldrecnbr: @building_params[:bldrecnbr])
    authorize @building
    
    success = @building.new_record? ? @building.save : @building.update(building_params)
    respond_with_notice(success, zone_building_path(@zone_id, @building), "Building was successfully added")
  end

  # PATCH/PUT /buildings/1 or /buildings/1.json
  def update
    @building_params = building_params
    @zone_id = @building_params[:zone_id]

    success = @building.update(building_params)
    respond_with_notice(success, zone_building_path(@zone_id, @building), "Building was successfully updated")
  end

  # DELETE /buildings/1 or /buildings/1.json
  def destroy
    @zone_id = @building[:zone_id]
    @zone = Zone.find(@zone_id)

    success = @zone.buildings.delete(@building)
    respond_with_notice(success, zone_buildings_path(@zone_id), "Building was successfully removed")
  end

  private
    def respond_with_notice(success, redirect, notice_text)
      respond_to do |format|
        if success
          format.html { redirect_to redirect, notice: notice_text }
          format.json { render :show, status: :ok, location: @building }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @building.errors, status: status }
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def building_params
      params.require(:building).permit(:bldrecnbr, :name, :nick_name, :abbreviation, :address, :city, :state, :zip, :zone_id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_building
      @building = Building.find(params[:id])
      authorize @building
    end

    def set_zone_id
      @zone_id = params.require(:zone_id)
    end
end

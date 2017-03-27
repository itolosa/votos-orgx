class FrontsController < ApplicationController
  before_action :set_front, only: [:show, :edit, :update, :destroy]

  # GET /fronts
  # GET /fronts.json
  def index
    @fronts = Front.all
    authorize Front
  end

  # GET /fronts/1
  # GET /fronts/1.json
  def show
    authorize @front
  end

  # GET /fronts/new
  def new
    @front = Front.new
    authorize Front
  end

  # GET /fronts/1/edit
  def edit
    authorize @front
  end

  # POST /fronts
  # POST /fronts.json
  def create
    @front = Front.new(front_params)
    authorize @front

    respond_to do |format|
      if @front.save
        format.html { redirect_to @front, notice: 'Front was successfully created.' }
        format.json { render :show, status: :created, location: @front }
      else
        format.html { render :new }
        format.json { render json: @front.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fronts/1
  # PATCH/PUT /fronts/1.json
  def update
    authorize @front
    respond_to do |format|
      if @front.update(front_params)
        format.html { redirect_to @front, notice: 'Front was successfully updated.' }
        format.json { render :show, status: :ok, location: @front }
      else
        format.html { render :edit }
        format.json { render json: @front.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fronts/1
  # DELETE /fronts/1.json
  def destroy
    authorize @front
    @front.destroy
    respond_to do |format|
      format.html { redirect_to fronts_url, notice: 'Front was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_front
      @front = Front.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def front_params
      params.params.require(:front).permit(:name)
    end
end

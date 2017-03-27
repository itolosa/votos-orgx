class ActivistFrontsController < ApplicationController
  before_action :set_activist_front, only: [:show, :edit, :update, :destroy]

  # GET /activist_fronts
  # GET /activist_fronts.json
  def index
    @activist_fronts = ActivistFront.all
    authorize ActivistFront
  end

  # GET /activist_fronts/1
  # GET /activist_fronts/1.json
  def show
    authorize @activist_front
  end

  # GET /activist_fronts/new
  def new
    @activist_front = ActivistFront.new
    authorize ActivistFront
  end

  # GET /activist_fronts/1/edit
  def edit
    authorize @activist_front
  end

  # POST /activist_fronts
  # POST /activist_fronts.json
  def create
    @activist_front = ActivistFront.new(activist_front_params)
    authorize @activist_front

    respond_to do |format|
      if @activist_front.save
        format.html { redirect_to @activist_front, notice: 'Activist front was successfully created.' }
        format.json { render :show, status: :created, location: @activist_front }
      else
        format.html { render :new }
        format.json { render json: @activist_front.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activist_fronts/1
  # PATCH/PUT /activist_fronts/1.json
  def update
    authorize @activist_front
    respond_to do |format|
      if @activist_front.update(activist_front_params)
        format.html { redirect_to @activist_front, notice: 'Activist front was successfully updated.' }
        format.json { render :show, status: :ok, location: @activist_front }
      else
        format.html { render :edit }
        format.json { render json: @activist_front.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activist_fronts/1
  # DELETE /activist_fronts/1.json
  def destroy
    authorize @activist_front
    @activist_front.destroy
    respond_to do |format|
      format.html { redirect_to activist_fronts_url, notice: 'Activist front was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activist_front
      @activist_front = ActivistFront.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activist_front_params
      params.fetch(:activist_front, {})
    end
end

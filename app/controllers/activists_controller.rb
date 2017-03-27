class ActivistsController < ApplicationController
  before_action :set_activist, only: [:show, :edit, :update, :destroy, :send_mail]
  skip_after_action :verify_authorized, only: [:login_from_token]
  
  # GET /activists
  # GET /activists.json
  def index
    @activists = Activist.all.order(:section_id, :name)
    authorize Activist
    respond_to do |format|
      format.html
      format.csv { send_data @activists.to_csv }
      format.xls
    end
  end

  # GET /activists/1
  # GET /activists/1.json
  def show
    authorize @activist
  end

  def send_mail
    authorize @activist
    ActivistMailer.sample_email(@activist).deliver_later
    respond_to do |format|
      format.html { redirect_to activists_url, notice: 'Activist mail enqueued for deliver!' }
      format.json { head :no_content }
    end
  end

  def login_from_token
    return
    #Rails.logger.info "maybe_login_from_token: '#{ params[:token] }'"
    if (token = params[:token]).blank?
      redirect_to root_path
      return 
    end

    if (activist = Activist.find_by_token(token))
      #Rails.logger.info "One time login token used for user #{ user.id }"
      unless activist.voted?
        sign_in(activist)
      end
    else
      #Rails.logger.info "No user found from token: '#{ token }'"
    end
    #skip_authorization
    #user_signed_in?
    # strip token regardless of success
    authorize Activist
    redirect_to new_vote_url, params.except(:token, :action, :controller)
  end

  # GET /activists/new
  def new
    @activist = Activist.new
    authorize Activist
  end

  # GET /activists/1/edit
  def edit
    authorize @activist
  end

  # POST /activists
  # POST /activists.json
  def create
    @activist = Activist.new(activist_params)
    @activist.fill_pass
    authorize @activist

    respond_to do |format|
      if @activist.save
        format.html { redirect_to @activist, notice: 'Activist was successfully created.' }
        format.json { render :show, status: :created, location: @activist }
      else
        format.html { render :new }
        format.json { render json: @activist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activists/1
  # PATCH/PUT /activists/1.json
  def update
    authorize @activist
    respond_to do |format|
      if @activist.update(activist_params)
        format.html { redirect_to @activist, notice: 'Activist was successfully updated.' }
        format.json { render :show, status: :ok, location: @activist }
      else
        format.html { render :edit }
        format.json { render json: @activist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activists/1
  # DELETE /activists/1.json
  def destroy
    authorize @activist
    @activist.destroy
    respond_to do |format|
      format.html { redirect_to activists_url, notice: 'Activist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activist
      @activist = Activist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activist_params
      params.require(:activist).permit(:name, :email, :vote_id, :section_id, front_ids: [])
    end
end

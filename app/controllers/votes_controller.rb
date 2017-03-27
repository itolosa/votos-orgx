class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
    authorize Vote
    respond_to do |format|
      format.html
      format.xls
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    authorize @vote
  end

  # GET /votes/new
  def new
    session[:vote_params] = {}
    @vote = Vote.new(session[:vote_params])
    @candidates = Candidate.all.order(:name)
    authorize Vote
  end

  # GET /votes/1/edit
  def edit
    authorize @vote
  end

  # POST /votes
  # POST /votes.json

  def confirm
    session[:vote_params].deep_merge!(params[:vote]) if params[:vote]
    @vote = Vote.new(session[:vote_params])
    authorize @vote
    if session[:vote_params]['candidate_ids'].select{|d| !d.blank? }.size>7
      respond_to do |format|
        flash[:notice] = 'no puede votar por los x candidatos'
        format.html {redirect_to new_vote_path, flash: {}}
      end      
    end
    @candidates = Candidate.where(id: session[:vote_params]['candidate_ids'])
  end

  def create
    session[:vote_params].deep_merge!(params[:vote]) if params[:vote]
    @vote = Vote.new(session[:vote_params])
    authorize @vote
    respond_to do |format|
      if @vote.save
        current_activist.vote = @vote
        current_activist.save!
        format.html { redirect_to root_path, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
        ActivistMailer.confirmation_email(current_activist).deliver_later
        sign_out
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    authorize @vote
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    authorize @vote
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(candidate_ids: [])
      
    end
end

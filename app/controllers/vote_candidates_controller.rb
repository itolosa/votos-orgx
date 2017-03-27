class VoteCandidatesController < ApplicationController
  before_action :set_vote_candidate, only: [:show, :edit, :update, :destroy]

  # GET /vote_candidates
  # GET /vote_candidates.json
  def index
    @vote_candidates = VoteCandidate.all
    authorize VoteCandidate
  end

  # GET /vote_candidates/1
  # GET /vote_candidates/1.json
  def show
    authorize @vote_candidate
  end

  # GET /vote_candidates/new
  def new
    @vote_candidate = VoteCandidate.new
    authorize VoteCandidate
  end

  # GET /vote_candidates/1/edit
  def edit
    authorize @vote_candidate
  end

  # POST /vote_candidates
  # POST /vote_candidates.json
  def create
    @vote_candidate = VoteCandidate.new(vote_candidate_params)
    authorize @vote_candidate

    respond_to do |format|
      if @vote_candidate.save
        format.html { redirect_to @vote_candidate, notice: 'Vote candidate was successfully created.' }
        format.json { render :show, status: :created, location: @vote_candidate }
      else
        format.html { render :new }
        format.json { render json: @vote_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote_candidates/1
  # PATCH/PUT /vote_candidates/1.json
  def update
    authorize @vote_candidate
    respond_to do |format|
      if @vote_candidate.update(vote_candidate_params)
        format.html { redirect_to @vote_candidate, notice: 'Vote candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote_candidate }
      else
        format.html { render :edit }
        format.json { render json: @vote_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote_candidates/1
  # DELETE /vote_candidates/1.json
  def destroy
    authorize @vote_candidate
    @vote_candidate.destroy
    respond_to do |format|
      format.html { redirect_to vote_candidates_url, notice: 'Vote candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_candidate
      @vote_candidate = VoteCandidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_candidate_params
      params.require(:vote_candidate).permit(:candidate_id, :vote_id)
    end
end

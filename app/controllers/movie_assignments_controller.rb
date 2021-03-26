class MovieAssignmentsController < ApplicationController
  before_action :set_movie_assignment, only: %i[ show edit update destroy ]

  # GET /movie_assignments or /movie_assignments.json
  def index
    @movie_assignments = MovieAssignment.all
  end

  # GET /movie_assignments/1 or /movie_assignments/1.json
  def show
  end

  # GET /movie_assignments/new
  def new
    @movie_assignment = MovieAssignment.new
  end

  # GET /movie_assignments/1/edit
  def edit
  end

  # POST /movie_assignments or /movie_assignments.json
  def create
    @movie_assignment = MovieAssignment.new(movie_assignment_params)

    respond_to do |format|
      if @movie_assignment.save
        format.html { redirect_to @movie_assignment, notice: "Movie assignment was successfully created." }
        format.json { render :show, status: :created, location: @movie_assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_assignments/1 or /movie_assignments/1.json
  def update
    respond_to do |format|
      if @movie_assignment.update(movie_assignment_params)
        format.html { redirect_to @movie_assignment, notice: "Movie assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @movie_assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_assignments/1 or /movie_assignments/1.json
  def destroy
    @movie_assignment.destroy
    respond_to do |format|
      format.html { redirect_to movie_assignments_url, notice: "Movie assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_assignment
      @movie_assignment = MovieAssignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_assignment_params
      params.require(:movie_assignment).permit(:movie_id, :user_id, :game_id)
    end
end

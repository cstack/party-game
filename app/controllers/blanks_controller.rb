class BlanksController < ApplicationController
  before_action :set_blank, only: %i[ show edit update destroy ]

  # GET /blanks or /blanks.json
  def index
    @blanks = Blank.all
  end

  # GET /blanks/1 or /blanks/1.json
  def show
  end

  # GET /blanks/new
  def new
    @blank = Blank.new
  end

  # GET /blanks/1/edit
  def edit
  end

  # POST /blanks or /blanks.json
  def create
    @blank = Blank.new(blank_params)

    respond_to do |format|
      if @blank.save
        format.html { redirect_to @blank, notice: "Blank was successfully created." }
        format.json { render :show, status: :created, location: @blank }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blanks/1 or /blanks/1.json
  def update
    respond_to do |format|
      if @blank.update(blank_params)
        format.html { redirect_to @blank, notice: "Blank was successfully updated." }
        format.json { render :show, status: :ok, location: @blank }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blanks/1 or /blanks/1.json
  def destroy
    @blank.destroy
    respond_to do |format|
      format.html { redirect_to blanks_url, notice: "Blank was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blank
      @blank = Blank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blank_params
      params.require(:blank).permit(:movie_id, :key, :value)
    end
end

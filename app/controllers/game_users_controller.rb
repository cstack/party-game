class GameUsersController < ApplicationController
  before_action :set_game_user, only: %i[ show edit update destroy ]

  # GET /game_users or /game_users.json
  def index
    @game_users = GameUser.all
  end

  # GET /game_users/1 or /game_users/1.json
  def show
  end

  # GET /game_users/new
  def new
    @game_user = GameUser.new
  end

  # GET /game_users/1/edit
  def edit
  end

  # POST /game_users or /game_users.json
  def create
    @game_user = GameUser.new(game_user_params)

    respond_to do |format|
      if @game_user.save
        format.html { redirect_to @game_user, notice: "Game user was successfully created." }
        format.json { render :show, status: :created, location: @game_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_users/1 or /game_users/1.json
  def update
    respond_to do |format|
      if @game_user.update(game_user_params)
        format.html { redirect_to @game_user, notice: "Game user was successfully updated." }
        format.json { render :show, status: :ok, location: @game_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_users/1 or /game_users/1.json
  def destroy
    @game_user.destroy
    respond_to do |format|
      format.html { redirect_to game_users_url, notice: "Game user was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_user
      @game_user = GameUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_user_params
      params.require(:game_user).permit(:game_id, :user_id)
    end
end

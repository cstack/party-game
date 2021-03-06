class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/1 or /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  def fill_in_the_blank
    Rails.logger.info("DEBUG - fill_in_the_blank #{params}")
    game = Game.find(params[:game_id])
    story = game.story_for(current_user)
    story.fill_in_the_blank(value: params[:value], user: current_user)
    helpers.broadcast_player_status_changed(game: game, user: current_user)
    if game.ready_to_advance_turn?
      Rails.logger.info("DEBUG - ready_to_advance_turn")
      game.advance_turn!
      helpers.broadcast_advance_turn(game: game)
    else
      Rails.logger.info("DEBUG - NOT ready_to_advance_turn")
    end
    room = game.room.from_perspective_of(current_user)
    render turbo_stream: turbo_stream.replace("room_#{room.id}", partial: "rooms/room.html.erb", locals: { room: room })
  end

  def change_answer
    game = Game.find(params[:game_id])
    story = game.story_for(current_user)
    story.undo_fill_in_the_blank!
    helpers.broadcast_player_status_changed(game: game, user: current_user)
    room = game.room.from_perspective_of(current_user)
    render turbo_stream: turbo_stream.replace("room_#{room.id}", partial: "rooms/room.html.erb", locals: { room: room })
  end

  def vote
    game = Game.find(params[:game_id])
    story = Story.find(params[:story_id])
    game.record_vote!(user: current_user, story: story)
    helpers.broadcast_player_status_changed(game: game, user: current_user)
    if game.all_votes_collected?
      helpers.broadcast_all_votes_in(game: game, current_user: current_user)
    end
    room = game.room.from_perspective_of(current_user)
    render turbo_stream: turbo_stream.replace("room_#{room.id}", partial: "rooms/room.html.erb", locals: { room: room })
  end

  def restart
    game = Game.find(params[:game_id])
    game.update!(status: 'cancelled')
    helpers.broadcast_game_restarted(room: game.room, current_user: current_user)
    room = game.room.from_perspective_of(current_user)
    render turbo_stream: turbo_stream.replace("room_#{room.id}", partial: "rooms/room.html.erb", locals: { room: room })
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    success = @game.update(game_params)
    respond_to do |format|
      if success
        format.html { redirect_to @game.room }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:status)
    end
end

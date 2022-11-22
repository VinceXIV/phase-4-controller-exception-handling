class BirdsController < ApplicationController
rescue ActiveRecord::RecordNotFound, with: :render_when_bird_not_found

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = find_bird(params)
    render json: bird
  end

  # PATCH /birds/:id
  def update
    bird = find_bird(params)
    bird.update(bird_params)
    render json: bird
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = find_bird(params)
    bird.update(likes: bird.likes + 1)
    render json: bird
  end

  # DELETE /birds/:id
  def destroy
    bird = find_bird(params)
    bird.destroy
    head :no_content
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def find_bird
    Bird.find(params[:id])
  end

  def render_when_bird_not_found
    render json: { error: "Bird not found" }, status: :not_found
  end

end

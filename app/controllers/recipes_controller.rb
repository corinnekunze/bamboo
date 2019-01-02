class RecipesController < ApiController
  before_action :find_recipe, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound do
    render json: {
      errors: "Recipe #{params[:id]} not found!"
    }, status: :not_found
  end

  def index
    render json: Recipe.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: {
        errors: @recipe.errors.full_messages.join(', ')
      }, status: :unprocessable_entity
    end
  end

  def show
    render json: @recipe
  end

  def destroy
    @recipe.destroy
    head :no_content
  end

  private

  def recipe_params
    params.permit(:name, :body)
  end

  def find_recipe
    @recipe = Recipe.find_by!(id: params[:id])
  end
end

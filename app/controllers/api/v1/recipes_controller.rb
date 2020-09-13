class Api::V1::RecipesController < ApplicationController
  def index
    recipes = Recipe.all.order(created_at: :desc)
    render json: recipes
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: { id: @recipe.id }
    else
      render json: @recipe.errors
    end
  end

  def show
    if recipe['error']
      render json: recipe, status: :not_found
    else
      render json: recipe
    end
  end

  def destroy
    recipe&.destroy
    render json: { message: 'Recipe deleted!' }
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :image, :ingredients, :instruction)
  end

  def recipe
    @recipe ||= Recipe.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      { error: e.to_s }
  end
end

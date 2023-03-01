class RecipesController < ApplicationController

  def index
    return render json: {errors: ["must be logged in to view recipes"]}, status: :unauthorized unless session[:user_id]
    recipes = Recipe.all
    render json: recipes, status: :created
  end

  def create
    return render json: {errors: ["must be logged in to create recipes"]}, status: :unauthorized unless session[:user_id]
    user = User.find_by(id: session[:user_id])
    recipe = user.recipes.create(recipe_params)
    
    if recipe.valid?
      render json: recipe, status: :created
    else
      render json: {errors: ["error message"]}, status: :unprocessable_entity
    end
  end

  private
  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
end

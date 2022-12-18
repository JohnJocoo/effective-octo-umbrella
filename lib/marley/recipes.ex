defmodule Marley.Recipes do
  @moduledoc """
  The Recipes context.
  """

  alias Marley.RecipesData

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes do
    RecipesData.preview_get_all()
  end

  @doc """
  Gets a single recipe.

  Raises if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

  """
  def get_recipe!(id) do
    RecipesData.fetch_by_id!(id)
  end
end

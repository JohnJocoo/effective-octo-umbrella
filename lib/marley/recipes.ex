defmodule Marley.Recipes do
  @moduledoc """
  The Recipes context.
  """

  alias Marley.Recipe
  alias Marley.RecipePreview

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%RecipePreview{}, ...]

  """
  def list_recipes do
    [%RecipePreview{id: 1, title: "Recipe one", image_url: "https://iamafoodblog.b-cdn.net/wp-content/uploads/2021/02/how-to-cook-steak-1061w.jpg"},
      %RecipePreview{id: 2, title: "Recipe two"},
      %RecipePreview{id: 3, title: "Recipe three"},
      %RecipePreview{id: 4, title: "Recipe four"},
      %RecipePreview{id: 5, title: "Recipe five"}]
  end

  @doc """
  Gets a single recipe.

  Raises if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

  """
  def get_recipe!(id) do
    %Recipe{
      id: id,
      title: "Recipe #{id}",
      description: "This is the recipe!",
      chef_name: "Anton",
      image_url: "https://iamafoodblog.b-cdn.net/wp-content/uploads/2021/02/how-to-cook-steak-1061w.jpg",
      tags: ["food", "ramen"]
    }
  end
end

defmodule Marley.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Marley.Recipes` context.
  """

  alias Marley.Recipe

  @doc """
  Generate a recipe.
  """
  def recipe_fixture(attrs \\ %{}) do
    recipe = %Recipe{
      chef_name: "some chef_name",
      description: "some description",
      image_url: "some image_url",
      tags: [],
      title: "some title",
      id: "id#{:rand.uniform(1000000)}"
    }
    Enum.reduce(attrs, recipe, fn {key, value}, recipe -> Map.replace!(recipe, key, value) end)
  end
end

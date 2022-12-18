defmodule Marley.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Marley.Recipes` context.
  """

  @doc """
  Generate a recipe.
  """
  def recipe_fixture(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> Enum.into(%{
        chef_name: "some chef_name",
        description: "some description",
        image_url: "some image_url",
        tags: [],
        title: "some title"
      })
      |> Marley.Recipes.create_recipe()

    recipe
  end
end

defmodule Marley.RecipesTest do
  alias Marley.Recipes

  use ExUnit.Case, async: false
  import Mock

  describe "recipes" do
    alias Marley.Recipe
    alias Marley.RecipesData

    import Marley.RecipesFixtures

    @invalid_attrs %{chef_name: nil, description: nil, image_url: nil, tags: nil, title: nil}

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      with_mock RecipesData, [preview_get_all: fn -> [recipe] end] do
        assert Recipes.list_recipes() == [recipe]
      end
    end

    test "get_recipe!/1 returns the recipe with given id" do
      %Recipe{id: id} = recipe = recipe_fixture()
      with_mock RecipesData, [fetch_by_id!: fn ^id -> recipe end] do
        assert Recipes.get_recipe!(recipe.id) == recipe
      end

    end
  end
end

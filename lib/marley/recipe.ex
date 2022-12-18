defmodule Marley.Recipe do

  defstruct [
    :id,
    :title,
    :description,
    :chef_name,
    image_url: nil,
    tags: []
  ]

end

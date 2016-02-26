defmodule SecLatestFilingsRssFeedParser.Helpers do
  @moduledoc """
  This module contains all the helpers needed for this library.
  """

  @doc """
  Helpers.extract_last_item/1 simply returns the last element
  of a tuple. It's used multiple times in the library and the
  tuple it is expecting might look like {[], [], ["hello"]},
  which when passed to the function, would return "hello"
  """

  def extract_last_item(tuple) do
    {_, _, item} = tuple
    item |> hd
  end
end

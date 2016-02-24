defmodule SecLatestFilingsRssFeedParser.Helpers do

  def extract_last_item(tuple) do
    {_, _, item} = tuple
    item |> hd
  end
end

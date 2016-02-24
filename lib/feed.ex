defmodule SecLatestFilingsRssFeedParser.Feed do

  alias SecLatestFilingsRssFeedParser.Helpers

  defstruct [:entry]

  def parse(xml) do
    %{
      updated: parse_updated(xml),
      entries: parse_feed(xml)
    }
  end

  defp parse_feed(xml) do
    Floki.find(xml, "entry")
    |> Enum.map(fn entry -> SecLatestFilingsRssFeedParser.Entry.parse(Floki.raw_html(entry)) end)
  end

  defp parse_updated(feed) do
    feed
    |> Floki.find("updated")
    |> hd
    |> Helpers.extract_last_item
  end
end

defmodule SecLatestFilingsRssFeedParser.Feed do
  import SweetXml

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

  defp extract_updated(tuple) do
    {_, _, updated_date} = tuple
    updated_date |> hd
  end

  defp parse_updated(feed) do
    feed
    |> Floki.find("updated")
    |> hd
    |> extract_updated
  end
end

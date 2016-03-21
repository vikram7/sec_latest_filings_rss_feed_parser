defmodule SecLatestFilingsRssFeedParser.Feed do
  @moduledoc """
  This module handles the parsing and creation of a feed
  map. A feed in the SEC's Latest Filings RSS Feed is defined
  by the content between opening <feed> and closing </feed>
  tags, including metadata and multiple entries
  """

  @doc """
  SecLatestFilingsRssFeedParser.parse/1 returns a map of
  a feed with its updated date and many entries.
  """

  def parse(xml) do
    %{
      updated: parse_updated(xml),
      entries: parse_feed(xml)
    }
  end

  defp parse_feed(xml) do
    Floki.find(xml, "entry")
    |> Enum.map(fn entry ->
      Floki.raw_html(entry)
      |> SecLatestFilingsRssFeedParser.Entry.parse
    end)
  end

  defp parse_updated(feed) do
    {_, _, [extracted_feed]} =
      feed
      |> Floki.find("updated")
      |> hd

    extracted_feed
  end
end

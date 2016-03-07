defmodule SecLatestFilingsRssFeedParser.Entry do
  @moduledoc """
  This module handles the parsing and creation of an entry
  map. An entry in the SEC's Latest Filings RSS Feed is defined
  by the content between opening <entry> and closing </entry>
  tags
  """

  alias SecLatestFilingsRssFeedParser.Helpers

  @doc """
  parse/1 takes an xml entry and parses it to return a map of that entry.
  """

  def parse(xml) do
    %{
      title: parse_title(xml),
      link: parse_link(xml),
      summary: parse_summary(xml),
      updated_date: parse_updated_date(xml),
      rss_feed_id: parse_rss_feed_id(xml),
      cik_id: parse_cik_id(xml),
      category: parse_category(xml)
    }
  end

  defp parse_category(xml) do
    {_, metadata, _} = xml
    |> Floki.find("category")
    |> hd

    {_, category} = metadata
    |> List.last

    category
  end

  defp parse_title(xml) do
    xml
    |> Floki.find("title")
    |> hd
    |> Helpers.extract_last_item
  end

  defp parse_link(xml) do
    regex = ~r/http(.*)index.htm/
    Regex.run(regex, xml, capture: :first)
    |> hd
  end

  defp parse_summary(xml) do
    xml
    |> Floki.find("summary")
    |> Floki.text
    |> String.strip
  end

  defp parse_updated_date(xml) do
    xml
    |> Floki.find("updated")
    |> hd
    |> Helpers.extract_last_item
  end

  defp parse_rss_feed_id(xml) do
    xml
    |> Floki.find("id")
    |> hd
    |> Helpers.extract_last_item
  end

  defp parse_cik_id(xml) do
    regex = ~r/\d{10}/
    title = parse_title(xml)

    Regex.run(regex, title, capture: :first)
    |> hd
  end
end

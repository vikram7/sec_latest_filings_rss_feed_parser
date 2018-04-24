defmodule SecLatestFilingsRssFeedParser.Entry do
  @moduledoc """
  This module handles the parsing and creation of an entry
  map. An entry in the SEC's Latest Filings RSS Feed is defined
  by the content between opening <entry> and closing </entry>
  tags
  """

  @doc """
  parse/1 takes an xml entry and parses it to return a map of that entry.
  """

  def parse(xml) do
    %{
      title: parse_title(xml),
      html_link: parse_html_link(xml),
      text_link: parse_text_link(xml),
      summary: parse_summary(xml),
      updated_date: parse_updated_date(xml),
      rss_feed_id: parse_rss_feed_id(xml),
      cik: parse_cik(xml),
      category: parse_category(xml)
    }
  end

  defp parse_category(xml) do
    {_, metadata, _} =
      xml
      |> Floki.find("category")
      |> hd

    {_, category} =
      metadata
      |> List.last

    category
  end

  defp parse_title(xml) do
    [{_, _, [title]}] =
      xml
      |> Floki.find("title")

    title
  end

  defp parse_html_link(xml) do
    regex = ~r/http(.*)index.htm/
    Regex.run(regex, xml, capture: :first)
    |> hd
  end

  defp parse_text_link(xml) do
    xml
    |> parse_html_link
    |> String.replace("-index.htm", ".txt")
  end

  defp parse_summary(xml) do
    xml
    |> Floki.find("summary")
    |> Floki.text
    |> String.trim
  end

  defp parse_updated_date(xml) do
    [{_, _, [updated]}] =
      xml
      |> Floki.find("updated")

    updated
  end

  defp parse_rss_feed_id(xml) do
    [{_, _, [id]}] =
      xml
      |> Floki.find("id")

    id
  end

  defp parse_cik(xml) do
    regex = ~r/\d{10}/
    title = parse_title(xml)

    Regex.run(regex, title, capture: :first)
    |> hd
  end
end

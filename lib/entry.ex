defmodule SecLatestFilingsRssFeedParser.Entry do

  defstruct [:title, :link, :summary, :updated_date, :rss_feed_id, :cik_id]

  def parse(xml) do
    %{
      title: parse_title(xml),
      link: parse_link(xml),
      summary: parse_summary(xml),
      updated_date: parse_updated_date(xml),
      rss_feed_id: parse_rss_feed_id(xml),
      cik_id: parse_cik_id(xml)
    }
  end

  defp extract_title(tuple) do
    {_, _, title} = tuple
    title |> hd
  end

  defp parse_title(xml) do
    xml
    |> Floki.find("title")
    |> hd
    |> extract_title
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

  defp extract_updated_date(tuple) do
    {_, _, updated} = tuple
    updated |> hd
  end

  defp parse_updated_date(xml) do
    xml
    |> Floki.find("updated")
    |> hd
    |> extract_updated_date
  end

  defp extract_rss_feed_id(tuple) do
    {_, _, rss_feed_id} = tuple
    rss_feed_id |> hd
  end

  defp parse_rss_feed_id(xml) do
    xml
    |> Floki.find("id")
    |> hd
    |> extract_rss_feed_id
  end

  defp parse_cik_id(xml) do
    regex = ~r/\(\d+\)/
    title = parse_title(xml)

    Regex.run(regex, title, capture: :first)
    |> hd
    |> String.split("(")
    |> tl
    |> hd
    |> String.split(")")
    |> hd
  end
end

defmodule CandyXml.Entry do
  import SweetXml

  defstruct [:title, :link, :summary, :updated_date, :rss_feed_id, :cik_id]

  def parse(xml) do
    %CandyXml.Entry{
      title: parse_title(xml),
      link: parse_link(xml),
      summary: parse_summary(xml),
      updated_date: parse_updated_date(xml),
      rss_feed_id: parse_rss_feed_id(xml),
      cik_id: parse_cik_id(xml)
    }
  end

  defp parse_title(xml) do
    xml
    |> xpath(~x"./title/text()"s)
  end

  defp parse_link(xml) do
    link_prefix = xml
    |> String.split("href=\"")
    |> tl
    |> hd
    |> String.split(".htm")
    |> hd
    link_prefix <> ".htm"
  end

  defp parse_summary(xml) do
    xml
    |> xpath(~x"./summary/text()"s)
    |> String.strip
  end

  defp parse_updated_date(xml) do
    xml
    |> xpath(~x"./updated/text()"s)
  end

  defp parse_rss_feed_id(xml) do
    xml
    |> xpath(~x"./id/text()"s)
  end

  defp parse_cik_id(xml) do
    regex = ~r/\(\d+\)/
    title = xml
    |> xpath(~x"./title/text()"s)

    Regex.run(regex, title, capture: :first)
    |> hd
    |> String.split("(")
    |> tl
    |> hd
    |> String.split(")")
    |> hd
  end
end


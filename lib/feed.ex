defmodule CandyXml.Feed do
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
    |> Enum.map(fn entry -> CandyXml.Entry.parse(Floki.raw_html(entry)) end)
  end

  defp parse_updated(feed) do
    feed
    |> xpath(~x"//feed/updated/text()"s)
  end
end

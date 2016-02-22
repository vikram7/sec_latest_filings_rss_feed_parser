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
    xml |> CandyXml.Entry.parse
  end

  defp parse_updated(feed) do
    feed
    |> xpath(~x"//entry/updated/text()")
  end
end

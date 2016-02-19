defmodule CandyXml.Feed do
  import SweetXml

  defstruct [:entry]

  def parse(xml) do
    %CandyXml.Feed{
      entry: parse_entry(xml)
    }
  end

  defp parse_entry(xml) do
    xml
    |> xpath(~x"//feed/entry")
    |> CandyXml.Entry.parse
  end
end

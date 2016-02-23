defmodule SecLatestFilingsRssFeedParserTest do
  use ExUnit.Case

  import SecLatestFilingsRssFeedParser

  test "parse!/1: parses RSS atom compliant XML" do
    xml = File.read!("test/fixtures/filings_atom_feed.xml")
    assert SecLatestFilingsRssFeedParser.parse!(xml)
  end

  test "parse!/1: raises error on invalid XML" do
    xml = "naw"
    assert_raise ArgumentError, fn -> parse!(xml) end
  end

  test "has an entry" do
    {:ok, xml} = File.read("test/fixtures/filings_atom_feed.xml")
    {:ok, feed} = xml |> parse
    assert feed.entries
  end
end

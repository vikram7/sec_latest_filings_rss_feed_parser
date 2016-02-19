defmodule CandyXmlTest do
  use ExUnit.Case

  import CandyXml

  # test "parse!/1: parses RSS atom compliant XML" do
  #   xml = File.read!("test/fixtures/filings_atom_feed.xml")
  #   assert parse!(xml)
  # end
  #
  # test "parse!/1: raises error on invalid XML" do
  #   xml = "naw"
  #   assert_raise RuntimeError, fn -> parse!(xml) end
  # end
  #
  # test "has an entry" do
  #   {:ok, feed} = File.read("test/fixtures/filings_atom_feed.xml") |> parse
  #   assert feed.entry
  # end
end

defmodule CandyXmlTest do
  use ExUnit.Case
  doctest CandyXml

  # https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&type=10-K&company=&dateb=&owner=include&start=0&count=100&output=atom
  # an <entry> has the following
  # filing
  # cik_id
  # link
  # rss_feed_id
  # summary
  # title
  # updated_date

  import CandyXml

  test "parse!/1: parses RSS atom compliant XML" do
    xml = File.read!("test/fixtures/filings_atom_feed.xml")
    assert parse!(xml)
  end

  test "parse!/1: raises error on invalid XML" do
    xml = "naw"
    assert_raise RuntimeError, fn -> parse!(xml) end
  end

  test "parses filing" do
    # get the filing
  end

  test "parses cik_id" do
    # get the cik_id
  end

  test "parses link" do
    # get the link
  end

  test "parses rss_feed_id" do
    # get the rss_feed_id
  end

  test "parses summary" do
    # get the summary
  end

  test "parses title" do
    # get the title
  end

  test "parses updated_date" do
    # get the updated_date
  end
end

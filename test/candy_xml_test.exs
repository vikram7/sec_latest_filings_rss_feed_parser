defmodule CandyXmlTest do
  use ExUnit.Case
  doctest CandyXml
  import CandyXml

  def entry_xml do
    """
    <entry>
      <title>10-K - GARMIN LTD (0001121788) (Filer)</title>
      <link rel="alternate" type="text/html" href="http://www.sec.gov/Archives/edgar/data/1121788/000161577416004243/0001615774-16-004243-index.htm"/>
      <summary type="html">
        &lt;b&gt;Filed:&lt;/b&gt; 2016-02-17 &lt;b&gt;AccNo:&lt;/b&gt; 0001615774-16-004243 &lt;b&gt;Size:&lt;/b&gt; 8 MB
      </summary>
      <updated>2016-02-17T17:24:49-05:00</updated>
      <category scheme="http://www.sec.gov/" label="form type" term="10-K"/>
      <id>urn:tag:sec.gov,2008:accession-number=0001615774-16-004243</id>
    </entry>
    """
  end

  # https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&type=10-K&company=&dateb=&owner=include&start=0&count=100&output=atom

  test "parse!/1: parses RSS atom compliant XML" do
    xml = Fiile.read!("test/fixtures/filings_atom_feed.xml")
    assert parse!(xml)
  end

  test "parse!/1: raises error on invalid XML" do
    xml = "naw"
    assert_raise RuntimeError, fn -> parse!(xml) end
  end

  test "has an entry" do
    {:ok, feed} = File.read("test/fixtures/filings_atom_feed.xml") |> parse
    assert feed.entry
  end

  test "parses cik_id" do
    {:ok, feed} = entry_xml |> parse
    assert.cik_id == '0001121788'
  end

  test "parses link" do
    {:ok, feed} = entry_xml |> parse
    assert.link == "http://www.sec.gov/Archives/edgar/data/1121788/000161577416004243/0001615774-16-004243-index.htm"
  end

  test "parses rss_feed_id" do
    {:ok, feed} = entry_xml |> parse
    assert.rss_feed_id = "urn:tag:sec.gov,2008:accession-number=0001615774-16-004243"
  end

  test "parses summary" do
    {:ok, feed} = entry_xml |> parse
    assert.summary = "&lt;b&gt;Filed:&lt;/b&gt; 2016-02-17 &lt;b&gt;AccNo:&lt;/b&gt; 0001615774-16-004243 &lt;b&gt;Size:&lt;/b&gt; 8 MB"
  end

  test "parses title" do
    {:ok, feed} = entry_xml |> parse
    assert.title = "10-K - GARMIN LTD (0001121788) (Filer)"
  end

  test "parses updated_date" do
    {:ok, feed} = entry_xml |> parse
    assert.updated_date = "2016-02-17T17:24:49-05:00"
  end
end

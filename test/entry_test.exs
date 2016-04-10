defmodule SecLatestFilingsRssFeedParserEntryTest do
  use ExUnit.Case

  import SecLatestFilingsRssFeedParser.Entry

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

  test "parses cik" do
    entry = entry_xml |> parse
    assert entry.cik == "0001121788"
  end

  test "parses category" do
    entry = entry_xml |> parse
    assert entry.category == "10-K"
  end

  test "parses link" do
    entry = entry_xml |> parse
    assert entry.link == "http://www.sec.gov/Archives/edgar/data/1121788/000161577416004243/0001615774-16-004243-index.htm"
  end

  test "parses rss_feed_id" do
    entry = entry_xml |> parse
    assert entry.rss_feed_id == "urn:tag:sec.gov,2008:accession-number=0001615774-16-004243"
  end

  test "parses summary" do
    entry = entry_xml |> parse
    assert entry.summary == "<b>Filed:</b> 2016-02-17 <b>AccNo:</b> 0001615774-16-004243 <b>Size:</b> 8 MB"
  end

  test "parses title" do
    entry = entry_xml |> parse
    assert entry.title == "10-K - GARMIN LTD (0001121788) (Filer)"
  end

  test "parses updated_date" do
    entry = entry_xml |> parse
    assert entry.updated_date == "2016-02-17T17:24:49-05:00"
  end
end

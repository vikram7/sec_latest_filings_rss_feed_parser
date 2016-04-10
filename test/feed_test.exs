defmodule SecLatestFilingsRssFeedParserFeedTest do
  use ExUnit.Case

  def feed_xml do
    """
    <?xml version="1.0" encoding="ISO-8859-1" ?>
    <feed xmlns="http://www.w3.org/2005/Atom">
      <title>Latest Filings - Wed, 17 Feb 2016 21:43:00 EST</title>
      <link rel="alternate" href="/cgi-bin/browse-edgar?action=getcurrent"/>
      <link rel="self" href="/cgi-bin/browse-edgar?action=getcurrent"/>
      <id>http://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent</id>
      <author><name>Webmaster</name><email>webmaster@sec.gov</email></author>
      <updated>2016-02-17T21:43:00-05:00</updated>
      <entry>
        <title>10-K - LENNOX INTERNATIONAL INC (0001069202) (Filer)</title>
        <link rel="alternate" type="text/html" href="http://www.sec.gov/Archives/edgar/data/1069202/000106920216000014/0001069202-16-000014-index.htm"/>
        <summary type="html">
          &lt;b&gt;Filed:&lt;/b&gt; 2016-02-16 &lt;b&gt;AccNo:&lt;/b&gt; 0001069202-16-000014 &lt;b&gt;Size:&lt;/b&gt; 24 MB
        </summary>
        <updated>2016-02-16T11:52:50-05:00</updated>
        <category scheme="http://www.sec.gov/" label="form type" term="10-K"/>
        <id>urn:tag:sec.gov,2008:accession-number=0001069202-16-000014</id>
      </entry>
      <entry>
        <title>10-K - CATERPILLAR FINANCIAL SERVICES CORP (0000764764) (Filer)</title>
        <link rel="alternate" type="text/html" href="http://www.sec.gov/Archives/edgar/data/764764/000076476416000111/0000764764-16-000111-index.htm"/>
        <summary type="html">
          &lt;b&gt;Filed:&lt;/b&gt; 2016-02-16 &lt;b&gt;AccNo:&lt;/b&gt; 0000764764-16-000111 &lt;b&gt;Size:&lt;/b&gt; 20 MB
        </summary>
        <updated>2016-02-16T11:24:30-05:00</updated>
        <category scheme="http://www.sec.gov/" label="form type" term="10-K"/>
        <id>urn:tag:sec.gov,2008:accession-number=0000764764-16-000111</id>
      </entry>
    </feed>
    """
  end

  test "parse/1" do
    feed = feed_xml |> SecLatestFilingsRssFeedParser.Feed.parse
    assert feed == %{
      updated: "2016-02-17T21:43:00-05:00",
      entries: [
        %{
          title: "10-K - LENNOX INTERNATIONAL INC (0001069202) (Filer)",
          link: "http://www.sec.gov/Archives/edgar/data/1069202/000106920216000014/0001069202-16-000014-index.htm",
          summary: "Filed: 2016-02-16 AccNo: 0001069202-16-000014 Size: 24 MB",
          updated_date: "2016-02-16T11:52:50-05:00",
          rss_feed_id: "urn:tag:sec.gov,2008:accession-number=0001069202-16-000014",
          cik: "0001069202",
          category: "10-K"
        },
        %{
          title: "10-K - CATERPILLAR FINANCIAL SERVICES CORP (0000764764) (Filer)",
          link: "http://www.sec.gov/Archives/edgar/data/764764/000076476416000111/0000764764-16-000111-index.htm",
          summary: "Filed: 2016-02-16 AccNo: 0000764764-16-000111 Size: 20 MB",
          updated_date: "2016-02-16T11:24:30-05:00",
          rss_feed_id: "urn:tag:sec.gov,2008:accession-number=0000764764-16-000111",
          cik: "0000764764",
          category: "10-K"
        }
      ]
    }
  end
end

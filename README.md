[![CircleCI](https://circleci.com/gh/vikram7/sec_latest_filings_rss_feed_parser.png?style=shield&circle-token=777d83f525af0daf7b4dd0a82b32751f25ea29eb)](https://circleci.com/gh/vikram7/sec_latest_filings_rss_feed_parser)[![HEX version](https://img.shields.io/hexpm/v/sec_recent_filings_rss_feed_parser.png)](https://hex.pm/packages/sec_recent_filings_rss_feed_parser)

# SecLatestFilingsRssFeedParser

This is a simple parser with one goal: to hit the SEC's Latest Filings RSS Feed and parse the XML to return back a workable format.

For example, if you went to the SEC's Latest Filings RSS Feed [here](https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&CIK=&type=10-K&company=&dateb=&owner=include&start=0&count=40&output=atom), you would see XML in the following format:

```xml
<?xml version="1.0" encoding="ISO-8859-1" ?>
<feed xmlns="http://www.w3.org/2005/Atom">
<title>Latest Filings - Thu, 25 Feb 2016 18:54:17 EST</title>
<link rel="alternate" href="/cgi-bin/browse-edgar?action=getcurrent"/>
<link rel="self" href="/cgi-bin/browse-edgar?action=getcurrent"/>
<id>http://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent</id>
<author><name>Webmaster</name><email>webmaster@sec.gov</email></author>
<updated>2016-02-25T18:54:17-05:00</updated>
<entry>
<title>10-K - TESORO CORP /NEW/ (0000050104) (Filer)</title>
<link rel="alternate" type="text/html" href="http://www.sec.gov/Archives/edgar/data/50104/000005010416000055/0000050104-16-000055-index.htm"/>
<summary type="html">
 &lt;b&gt;Filed:&lt;/b&gt; 2016-02-25 &lt;b&gt;AccNo:&lt;/b&gt; 0000050104-16-000055 &lt;b&gt;Size:&lt;/b&gt; 23 MB
</summary>
<updated>2016-02-25T17:29:49-05:00</updated>
<category scheme="http://www.sec.gov/" label="form type" term="10-K"/>
<id>urn:tag:sec.gov,2008:accession-number=0000050104-16-000055</id>
</entry>
<entry>
<title>10-K - BB&amp;T CORP (0000092230) (Filer)</title>
<link rel="alternate" type="text/html" href="http://www.sec.gov/Archives/edgar/data/92230/000009223016000125/0000092230-16-000125-index.htm"/>
<summary type="html">
 &lt;b&gt;Filed:&lt;/b&gt; 2016-02-25 &lt;b&gt;AccNo:&lt;/b&gt; 0000092230-16-000125 &lt;b&gt;Size:&lt;/b&gt; 28 MB
</summary>
<updated>2016-02-25T17:25:57-05:00</updated>
<category scheme="http://www.sec.gov/" label="form type" term="10-K"/>
<id>urn:tag:sec.gov,2008:accession-number=0000092230-16-000125</id>
</entry>
.
.
.
<entry>
<title>10-K - Benefitfocus,Inc. (0001576169) (Filer)</title>
<link rel="alternate" type="text/html" href="http://www.sec.gov/Archives/edgar/data/1576169/000119312516478532/0001193125-16-478532-index.htm"/>
<summary type="html">
 &lt;b&gt;Filed:&lt;/b&gt; 2016-02-25 &lt;b&gt;AccNo:&lt;/b&gt; 0001193125-16-478532 &lt;b&gt;Size:&lt;/b&gt; 7 MB
</summary>
<updated>2016-02-25T17:05:40-05:00</updated>
<category scheme="http://www.sec.gov/" label="form type" term="10-K"/>
<id>urn:tag:sec.gov,2008:accession-number=0001193125-16-478532</id>
</entry>
</feed>
```

The XML has a `feed`, which has many `entries`. Parsing the feed (`SecLatestFilingsRssFeedParser.parse(xml_document)`) would return an Elixir map that looks like the following:

```elixir
{:ok,
 %{entries: [%{cik_id: "0000050104",
      link: "http://www.sec.gov/Archives/edgar/data/50104/000005010416000055/0000050104-16-000055-index.htm",
      rss_feed_id: "urn:tag:sec.gov,2008:accession-number=0000050104-16-000055",
      summary: "Filed: 2016-02-25 AccNo: 0000050104-16-000055 Size: 23 MB",
      title: "10-K - TESORO CORP /NEW/ (0000050104) (Filer)",
      updated_date: "2016-02-25T17:29:49-05:00"},
    %{cik_id: "0000092230",
      link: "http://www.sec.gov/Archives/edgar/data/92230/000009223016000125/0000092230-16-000125-index.htm",
      rss_feed_id: "urn:tag:sec.gov,2008:accession-number=0000092230-16-000125",
      summary: "Filed: 2016-02-25 AccNo: 0000092230-16-000125 Size: 28 MB",
      title: "10-K - BB&T CORP (0000092230) (Filer)",
      updated_date: "2016-02-25T17:25:57-05:00"},
      rss_feed_id: "urn:tag:sec.gov,2008:accession-number=0001275477-16-000111",
      summary: "Filed: 2016-02-25 AccNo: 0001275477-16-000111 Size: 8 MB",
      title: "10-K - Orchid Island Capital, Inc. (0001518621) (Filer)",
      updated_date: "2016-02-25T17:19:42-05:00"},
    .
    .
    .
    %{cik_id: "0001576169",
      link: "http://www.sec.gov/Archives/edgar/data/1576169/000119312516478532/0001193125-16-478532-index.htm",
      rss_feed_id: "urn:tag:sec.gov,2008:accession-number=0001193125-16-478532",
      summary: "Filed: 2016-02-25 AccNo: 0001193125-16-478532 Size: 7 MB",
      title: "10-K - Benefitfocus,Inc. (0001576169) (Filer)",
      updated_date: "2016-02-25T17:05:40-05:00"}],
   updated: "2016-02-25T18:54:17-05:00"}}
```

An entry's map contains a `cik_id` (the identifier the SEC uses for a company or security), a `link` to the filing, an `rss_feed_id` which represents a unique id of the entry, a `summary` which is a short summary of the document, a filing `title` and an `updated_date`. The feed is a map of those entries and an `updated` date of the feed.

Be bold, use this tool to bring some sanity to parsing the SEC's XML feed and feel free to contribute!

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add sec_latest_filings_rss_feed_parser to your list of dependencies in `mix.exs`:

        def deps do
          [{:sec_latest_filings_rss_feed_parser, "~> 0.0.1"}]
        end

  2. Ensure sec_latest_filings_rss_feed_parser is started before your application:

        def application do
          [applications: [:sec_latest_filings_rss_feed_parser]]
        end

## License

This library is under the MIT [license](LICENSE.md).

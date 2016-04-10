defmodule SecLatestFilingsRssFeedParser.Mixfile do
  use Mix.Project

  def project do
    [app: :sec_recent_filings_rss_feed_parser,
     version: "0.0.5",
     elixir: "~> 1.2",
     description: description,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:floki, :logger]]
  end

  defp deps do
    [{:floki, "~> 0.8.0"}]
  end

  defp description do
    """
    XML Parser for the SEC's Latest Filings Feed
    An example of such a feed can be found here:
    https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&CIK=&type=10-K&company=&dateb=&owner=include&start=0&count=40&output=atom
    """
  end

  defp package do
    [maintainers: ["Vikram Ramakrishnan"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/vikram7/sec_latest_filings_rss_feed_parser"}]
  end
end

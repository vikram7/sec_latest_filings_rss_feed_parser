defmodule SecLatestFilingsRssFeedParserHelpersTest do
  use ExUnit.Case

  import SecLatestFilingsRssFeedParser.Helpers

  test "extract_last_item/1 returns last item of tuple" do
    tuple = {[], "wut", ["thing"]}

    assert extract_last_item(tuple) == "thing"
  end
end

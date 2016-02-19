defmodule CandyXml do
  def parse(xml) do
    {:ok, CandyXml.Feed.parse(xml)}
  catch
    :exit, _ -> {:error, "expected element start tag"}
  end

  def parse!(xml) do
    case parse(xml) do
      {:ok, feed} -> feed
      {:error, error} -> raise error
    end
  end
end

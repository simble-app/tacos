defmodule Tacos.Parsers.Yaml do
  @behaviour Tacos.Parser

  def parse(data) do
    :yamerl_constr.string(data)
  end
end

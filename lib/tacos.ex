defmodule Tacos do
  require Logger

  alias Tacos.Parsers.Json
  alias Tacos.Parsers.Yaml

  @spec tacos(name :: [String.t] | [atom]) :: [any]
  def tacos(names) when is_list(names) do
    taco_path_from_list(names) |> List.flatten |> Enum.map(&tacos/1)
  end

  @spec tacos(name :: String.t) :: any
  def tacos(name) do
    taco = taco_path(name)
    cond do
      taco_available?(taco) ->
        fetch_taco(taco) |> taqueria

      true ->
        raise "Taco fetch error! The taco (#{taco}) does not exist!"
    end
  end

  defp taqueria(taco) do
    case taco_format do
      "json" -> Json.parse(taco)
      "yaml" -> Yaml.parse(taco)
    end
  end

  defp fetch_taco(taco) do
    case File.read(taco) do
      {:ok, file} ->
        file

      {:error, file} ->
        raise "Taco fetch error! The taco (#{taco}) exists but cannot be read."
    end
  end

  defp taco_available?(taco) do
    File.exists?(taco)
  end

  defp taco_path(taco_name) do
    Path.join(tacos_path, "#{taco_name}.#{taco_format}")
  end

  defp taco_path_from_list(name) when is_atom(name) do
    Atom.to_string(name)
  end

  defp taco_path_from_list(name) when is_binary(name) do
    name
  end

  defp taco_path_from_list(names) when is_list(names) do
    Enum.map(names, &taco_path_from_list/1)
  end

  defp taco_path_from_list({group, name}) when is_list(name) do
    taco_path_from_list(name) |> Enum.map(&( Path.join(["#{group}"], &1) ))
  end

  defp taco_path_from_list({group, name}) do
    Path.join(["#{group}"], taco_path_from_list(name))
  end

  defp taco_format do
    Keyword.get(tacos_config || [], :format, "json")
  end

  def tacos_path do
    case Mix.env do
      :test ->
        test_tacos_path

      _ ->
        data_tacos_path

    end
  end

  def data_tacos_path do
    Keyword.get(tacos_config || [], :tacos_path, "tacos/data")
  end

  def test_tacos_path do
    Keyword.get(tacos_config || [], :tacos_path, "tacos/test")
  end

  def all_tacos_paths do
    specific = System.get_env("TACOS_PATH")
    case specific do
      nil -> _all_default_tacos_paths
      _ -> [specific]
    end
  end

  defp _all_default_tacos_paths do
    [
      data_tacos_path,
      test_tacos_path
    ]
  end

  def tacos_config do
    Application.get_env(:tacos, :tacos)
  end
end

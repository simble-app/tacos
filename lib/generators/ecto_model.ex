defmodule Tacos.Generators.EctoModel do
  alias Tacos.Encoders.Json

  def run(models) do
    Enum.map(models, &generate_taco/1)
  end

  defp generate_taco(module_name) do
    { model, _ } = Code.eval_string("%#{module_name}{}")

    data = deal_with_relationships(model, module_name)
      |> Map.delete(:__struct__)
      |> Map.delete(:__meta__)
      |> Map.delete(:_vex)
      |> Map.delete(:id)
      |> Map.delete(:errors)
      |> Map.delete(:inserted_at)
      |> Map.delete(:updated_at)
      |> encode

    model_name = String.split("#{module_name}", ".") |> List.last
    {model_name, data}
  end

  defp deal_with_relationships(model, module_name) do
    { mod, _ } = Code.eval_string("#{module_name}")

    relationship_stub = for {relationship, _} <- mod.changeset(model).types, into: %{} do
      {relationship, nil}
    end

    Map.merge(model, relationship_stub)
  end

  defp encode(model) do
    try do
      Json.encode(model)
    rescue
      e in RuntimeError ->
        bad_key_regex = ~r/association\s:(\w+)\sfrom/ix

        bad_key =
        Regex.run(bad_key_regex, e.message)
        |> List.last
        |> String.to_atom

        Map.delete(model, bad_key)
        |> encode
    end
  end
end

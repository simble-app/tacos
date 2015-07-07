defmodule TacosTest do
  use ExUnit.Case

  test "orders a single taco by name (string)" do
    spike = Tacos.tacos("spike")

    assert spike["first_name"] == "Spike"
    assert spike["last_name"] == "Spiegel"
    assert spike["email"] == "spike@the-bebop.com"
  end

  test "orders a single taco by name (atom)" do
    spike = Tacos.tacos(:spike)

    assert spike["first_name"] == "Spike"
    assert spike["last_name"] == "Spiegel"
    assert spike["email"] == "spike@the-bebop.com"
  end

  test "orders a multiple tacos ([String.t])" do
    tacos = Tacos.tacos(["spike", "faye"])
    spike = List.first(tacos)
    faye = List.last(tacos)

    assert spike["first_name"] == "Spike"
    assert spike["last_name"] == "Spiegel"
    assert spike["email"] == "spike@the-bebop.com"

    assert faye["first_name"] == "Faye"
    assert faye["last_name"] == "Valentine"
    assert faye["email"] == "faye@the-bebop.com"
  end

  test "orders a multiple tacos ([atom])" do
    tacos = Tacos.tacos([:spike, :faye])
    spike = List.first(tacos)
    faye = List.last(tacos)

    assert spike["first_name"] == "Spike"
    assert spike["last_name"] == "Spiegel"
    assert spike["email"] == "spike@the-bebop.com"

    assert faye["first_name"] == "Faye"
    assert faye["last_name"] == "Valentine"
    assert faye["email"] == "faye@the-bebop.com"
  end

  test "orders a grouped taco ([{atom, atom}])" do
    tacos = Tacos.tacos(users: :ein)
    ein = List.first(tacos)

    assert ein["name"] == "ein"
    assert ein["id"] == 1
  end

  test "orders grouped tacos ([{atom, String.t}])" do
    tacos = Tacos.tacos(users: "ein")
    ein = List.first(tacos)

    assert ein["name"] == "ein"
    assert ein["id"] == 1
  end

  test "orders grouped tacos ([{atom, [String.t]}])" do
    tacos = Tacos.tacos(users: ["ein", "jet"])
    ein = List.first(tacos)

    jet = List.last(tacos)

    assert ein["name"] == "ein"
    assert ein["id"] == 1

    assert jet["name"] == "jet"
    assert jet["id"] == 32
  end

  test "orders a deeploy grouped tacos ([{atom, ... {atom}])" do
    tacos = Tacos.tacos(users: [active: [admin: [:ed]]])
    ed = List.first(tacos)

    assert ed["email"] == "ed@the-bebop.com"
    assert ed["id"] == 2
  end

  test "orders a deeploy grouped tacos ([{atom, ... {String.t}])" do
    tacos = Tacos.tacos(users: [active: [admin: ["ed"]]])
    ed = List.first(tacos)

    assert ed["email"] == "ed@the-bebop.com"
    assert ed["id"] == 2
  end
end

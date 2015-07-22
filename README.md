Tacos
=====

A fixture library for Elixir

## Features

* JSON fixutre support
* YAML fixture support 
* Mix task for generating (empty) fixtures from Ecto models

## Instructions

### Installation

Add to your `mix.exs`

`{:tacos, github: "simble-app/tacos", tag: "v0.0.1"}`

### Setup

Setup a directory for your tacos (fixtures). The default is `test/tacos`

```bash
$ mix tacos.setup
```

Now configure tacos in your `config/*.exs` files, configure where to find tacos.

```elixir
# Ex. Configuration for the test environment
# config/test.exs

config :tacos, :tacos,
  tacos_path: "tacos/test",
  format: "json"

# Ex. All environments not "test"
# config/config.exs
config :tacos, :tacos,
  tacos_path: "tacos/data",
  format: "json"
```

### Usage

#### Tacos#tacos
Fairly straightforward, examples below are from the tests. Tacos tolerates string(s), atom(s), or keyword list with string, or atom, values.

```elixir
# Fixtures can be retrieved one at a time
#
# tacos/test/spike.json
spike = Tacos.tacos("spike")

# Fixtures can be retrieved as a list
#
# tacos/test/spike.json
# tacos/test/faye.json
[spike, faye] = Tacos.tacos([:spike, :faye])
# Fixtures can be grouped (using directories)
#
# tacos/test/users/ein.json
[ein] = Tacos.tacos(users: :ein)

# Fixtures can be grouped (using directories)
#
# tacos/test/users/ein.json
# tacos/test/users/jet.json
[ein, jet] = Tacos.tacos(users: ["ein", "jet"])

# Fixtures can be deeply nested
#
# tacos/test/users/active/admin/ed.json
[edward] = Tacos.tacos(users: [active: [admin: [:ed]]])
```

### Mix Tasks

#### Initial Setup

Create the necessary directories for tacos (data and test)

```bash
$ mix tacos.setup
```

#### Ecto and/or Vex Integration

Tacos has a mix task to generate fixtures from Ecto models, or structs/maps using Vex <sup>[1,2]</sup>.

```bash
#  Simple
$ mix tacos.gen.model TheBebop.Crew

# Specify the base path (relative to the application root)
$ TACOS_PATH="delicious_tacos" mix tacos.gen.model TheBebop.Crew
```

<sub>*1* It actually works with _any_ struct (filters out `:__struct__`) or map.</sub><br><sub>*2* The reason it "works" with Ecto and/or Vex models is because it _also_ filters out: `:__meta__, :__id__, :inserted_at, :updated_at, :errors, :_vex`</sub>

## Misc

### Known Limitations Issues

* No support for YAML fixture generation because I couldn't find an Elixir/Erlang libary to do (serialize) it.
* It automatically strips some keys, see Ecto/Vex Integration for specifics. If someone needs this configurable, create an issue or PR.

### Possible Features

* JSON-Schema support
* Rich fixture generation from JSON-Schema support

### Why?

1. There aren't any other fixture libraries for Elixir
1. It seemed easy enough to do?  ¯\\_(ツ)_/¯
1. I don't like factories, nay... I _hate_ factories
1. Community profit?
1. Tacos are delicious

### Pull Requests

1. Pull requests _must_ pass tests _and_ add full coverage.
1. You only need to add coverage to _publicly_ available methods.

### License

Tacos is released under the [MIT License](http://www.opensource.org/licenses/MIT).

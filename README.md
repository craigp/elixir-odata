
elixir-odata
============
[![Build Status](https://secure.travis-ci.org/craigp/elixir-odata.png?branch=master "Build Status")](http://travis-ci.org/craigp/elixir-odata)
[![Coverage Status](https://coveralls.io/repos/craigp/elixir-odata/badge.svg?branch=master&service=github)](https://coveralls.io/github/craigp/elixir-odata?branch=master)
[![hex.pm version](https://img.shields.io/hexpm/v/odata.svg)](https://hex.pm/packages/odata)
[![hex.pm downloads](https://img.shields.io/hexpm/dt/odata.svg)](https://hex.pm/packages/odata)
[![Inline docs](http://inch-ci.org/github/craigp/elixir-odata.svg?branch=master&style=flat)](http://inch-ci.org/github/craigp/elixir-odata)

OData for Elixir, or something resembling it

You can find the hex package [here](https://hex.pm/packages/odata), and the docs [here](http://hexdocs.pm/odata).

## Usage

First, add the client to your `mix.exs` dependencies:

```elixir
def deps do
  [{:odata, "~> 0.1"}]
end
```

Then run `$ mix do deps.get, compile` to download and compile your dependencies.

Finally, add the `:odata` application as your list of applications in `mix.exs`:

```elixir
def application do
  [applications: [:logger, :odata]]
end
```

## TODO

* [ ] Everything


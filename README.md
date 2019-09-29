# IntSupport

An Elixir library that is porting Rail's ActiveSupport numeric and integer core extensions.

## Documentation

Documentaiton can be found [here](https://hexdocs.pm/int_support/IntSupport.html#content).

## Installation

The package can be installed by adding `int_support` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:int_support, "~> 0.1.0"}
  ]
end
```

## Examples

#### ordinalize

```elixir
iex> IntSupport.ordinalize(1)
"1st"
iex> IntSupport.ordinalize(2)
"2nd"
```

#### to_phone_number
```elixir
iex> IntSupport.to_phone_number(5551234)
"555-1234"
iex> IntSupport.to_phone_number(1235554444)
"(123) 555-4444"
```

## TODO
Anything found [here](https://guides.rubyonrails.org/active_support_core_extensions.html) that could take an elixir integer and return a value.

- [bytes](https://guides.rubyonrails.org/active_support_core_extensions.html#bytes)
- Change from int_support to generic support module and add float, list, and map ActiveSupport ports

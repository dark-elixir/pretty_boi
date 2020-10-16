defmodule PrettyBoi.SigilANSI do
  @moduledoc """
  Custom applescript sigil.
  """

  @type opts() :: []

  @colors [
    light_black: "lbl",
    light_blue: "lb",
    light_cyan: "lc",
    light_green: "lg",
    light_magenta: "lm",
    light_red: "lr",
    light_yellow: "ly",
    black: "bl",
    blue: "b",
    cyan: "c",
    green: "g",
    magenta: "m",
    red: "r",
    yellow: "y"
  ]
  @backgrounds [
    light_black_background: "LBL",
    light_blue_background: "LB",
    light_cyan_background: "LC",
    light_green_background: "LG",
    light_magenta_background: "LM",
    light_red_background: "LR",
    light_yellow_background: "LY",
    black_background: "BL",
    blue_background: "B",
    cyan_background: "C",
    green_background: "G",
    magenta_background: "M",
    red_background: "R",
    yellow_background: "Y"
  ]

  @raw_color_regex_parts (for {name, color} <- @colors do
                            "(?<#{name}>#{color})"
                          end)
  @raw_background_regex_parts (for {name, background} <- @backgrounds do
                                 "(?<#{name}>#{background})"
                               end)

  @opts_regex ~r/^#{Enum.join(@raw_color_regex_parts, "|")}|#{
                Enum.join(@raw_background_regex_parts, "|")
              }$/

  @doc """
  Converts a `binary` into an OSA script for applescripts.
  """
  @spec sigil_p(String.t(), opts()) :: String.t()
  def sigil_p("", opts) when is_list(opts) do
    ""
  end

  def sigil_p(binary, []) when is_binary(binary) do
    binary
  end

  def sigil_p(binary, opts) when is_binary(binary) do
    "#{format(opts)}" <> binary <> "#{IO.ANSI.reset()}"
  end

  def format(iolist) do
    regex_string =
      "^#{Enum.join(@raw_color_regex_parts, "|")}#{Enum.join(@raw_background_regex_parts, "|")}$"

    IO.inspect(regex_string)
    captures = Regex.named_captures(@opts_regex, to_string(iolist))
    IO.inspect(opts: iolist)
    IO.inspect(alla: Regex.named_captures(@opts_regex, to_string(iolist), capture: :all))
    IO.inspect(alls: Regex.scan(@opts_regex, to_string(iolist), capture: :all))

    sanitize_captures(captures)

    IO.ANSI.red()
  end

  def sanitize_captures(captures) do
    IO.inspect(captures: captures)

    captures =
      for {name, capture} <- captures,
          capture not in [""] do
        {name, capture}
      end

    IO.inspect(captures: captures)

    colors =
      for {name, capture} <- captures,
          atom_name = String.to_existing_atom(name),
          capture == @colors[atom_name] do
        # {atom_name, capture}
        atom_name
      end

    backgrounds =
      for {name, capture} <- captures,
          atom_name = String.to_existing_atom(name),
          capture == @backgrounds[atom_name] do
        # {atom_name, capture}
        atom_name
      end

    IO.inspect(colors: colors)
    IO.inspect(backgrounds: backgrounds)

    color =
      for color <- colors, reduce: "" do
        acc -> acc <> apply(IO.ANSI, color, [])
      end

    background =
      for background <- backgrounds, reduce: "" do
        acc -> acc <> apply(IO.ANSI, background, [])
      end

    color <> background
  end

  def colors do
    @colors
  end

  def backgrounds do
    @backgrounds
  end
end

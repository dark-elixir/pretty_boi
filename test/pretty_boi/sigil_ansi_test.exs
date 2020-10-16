defmodule PrettyBoi.SigilANSITest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias PrettyBoi.SigilANSI
  import SigilANSI

  @cases_no_opts [
    {:empty, "", ""},
    {:simple_1, "simple", "simple"}
  ]

  @cases_r [
    {:empty, "", ""},
    {:simple_1, "simple", "\e[31msimple\e[0m"},
    {:simple_2, "simple\n\n", "\e[31msimple\n\n\e[0m"}
  ]

  @cases_rg [
    {:empty, "", ""},
    {:simple_1, "simple", "\e[31msimple\e[0m"},
    {:simple_2, "simple\n\n", "\e[31msimple\n\n\e[0m"}
  ]

  @cases_color [
    # {:empty, "", ""},
    {:simple_1, "simple", "\e[31msimple\e[0m"}
    # {:simple_2, "simple\n\n", "\e[31msimple\n\n\e[0m"}
  ]

  describe ".sigil_p/1" do
    for {label, given, expected} <- @cases_no_opts do
      test "given {inspect(given)} #{label} it returns {inspect(expected)}}" do
        assert SigilANSI.sigil_p(unquote(given), []) == unquote(expected)
      end
    end
  end

  describe "~p/1" do
    for {label, given, expected} <- @cases_no_opts do
      test "given {inspect(given)} #{label} it returns {inspect(expected)}}" do
        assert ~p(#{unquote(given)}) == unquote(expected)
      end
    end
  end

  describe ".sigil_p/2 (option 'r')" do
    for {label, given, expected} <- @cases_color do
      test "given {inspect(given)} #{label} it returns {inspect(expected)}}" do
        assert SigilANSI.sigil_p(unquote(given), 'bB') == unquote(expected)
      end
    end
  end

  # describe "~p/2" do
  #   for {label, given, expected} <- @cases_color do
  #     test "given {inspect(given)} #{label} it returns {inspect(expected)}}" do
  #       assert ~p(#{unquote(given)})bl == unquote(expected)
  #     end
  #   end
  # end

  # describe ".sigil_p/2 (option 'rg')" do
  #   for {label, given, expected} <- @cases_rg do
  #     test "given {inspect(given)} #{label} it returns {inspect(expected)}}" do
  #       assert SigilANSI.sigil_p(unquote(given), 'rg') == unquote(expected)
  #     end
  #   end
  # end
end

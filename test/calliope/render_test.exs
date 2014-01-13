defmodule CalliopeRenderTest do
  use ExUnit.Case

  import Calliope.Render

  test "render a div with inline content" do
    haml = "%div Hello Calliope"
    assert "<div>Hello Calliope</div>" == render(haml)
  end

  test "render a div with nested content" do
    haml = "%div\n\tHello Calliope"
    assert "<div>Hello Calliope</div>" == render(haml)
  end

  test "render a div with nested div" do
    haml = "%div\n\t%div Hello World"
    assert "<div><div>Hello World</div></div>" == render(haml)
  end
end

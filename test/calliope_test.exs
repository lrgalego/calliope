defmodule CalliopeTest do
  use ExUnit.Case

  import Calliope.Engine

  test :empty_render do
    assert render("") == ""
  end

  test :render_divs do
    # assert render("%div") == "<div></div>"
    # assert render(".muses") == "<div class='muses'></div>"
  end

end

defmodule CalliopeTagsTest do
  use ExUnit.Case

  import Calliope.Tags

  test :div do
    assert div(".new") == "%div.new"
    assert div("#div_with_id") == "%div#div_with_id"
  end

end

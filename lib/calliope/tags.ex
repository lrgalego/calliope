defmodule Calliope.Tags do


  @tag_matcher       %r{([#|.]?[:\w]+)}
  @attribute_matcher %r{((?:\\.|\#(?!\{)|[^["']\\#])*)(["']|#\{)}

  def tag_matcher(tag), do: Regex.run(@tag_matcher, tag) |> Enum.first

  def div(tag, whitespace), do: "%div#{tag_matcher(tag)}"

end

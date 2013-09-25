defmodule Calliope.Parser do

  import Calliope.Tags

  @line_matcher      %r{(([ \t]+)?(.*?))(?:\Z|\r\n|\r|\n)}

  defrecord Node, full: "", value: "", whitespace: 0, children: []


  def parse(haml) do
    clean_text(haml) |>
      haml_to_tuple  |>
      build_tree     |>
      process_tree   |>
      Enum.join("\n")
  end

  defp clean_text(text), do: String.strip(text)

  defp haml_to_tuple(haml) do
    match_lines(haml, @line_matcher) |> remove_last_line |> to_tuple
  end

  defp match_lines(haml, matcher), do: Regex.scan(matcher, haml)

  defp remove_last_line(lines), do: Enum.take(lines, -1)

  defp to_tuple(lines) do
    Enum.map lines, fn(line) -> read_line_to_tuple(line) end
  end

  defp read_line_to_tuple([ full, element, whitespace, _ ]), do: { full, element, whitespace }

  defp build_tree([h|t]), do: [branch(h, t)]

  defp branch({ full, element, whitespace }, []) do
    new_node(full, element, whitespace, [])
  end
  defp branch({ full, element, whitespace }, [{ f, e, ws}|t]) when ws > whitespace do
    new_node(full, element, whitespace, [branch({ f, e, ws}, t)])
  end
  defp branch({ full, element, whitespace }, [{ _, _, ws}|_]) when ws == whitespace do
    branch({ full, element, whitespace }, [])
  end

  defp new_node(full, value, whitespace, children) do
    Node.new(full: full, value: clean_text(value), whitespace: String.length(whitespace), children: children)
  end

  defp process_tree([]), do: []
  defp process_tree([h|t]) do
    [open_node(h), process_tree(h.children), close_node(h)] ++ process_tree(t)
  end

  defp open_node(node) do
    node.value
  end

  defp close_node(node) do
    node.value
  end

end

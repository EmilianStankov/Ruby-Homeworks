def format_string(string, width)
  result = string.split.join(" ").upcase
  if result.length < width
    result.prepend(" " * ((width - result.length) / 2).floor)
    result << " " * ((width - result.length))
  end
  result
end
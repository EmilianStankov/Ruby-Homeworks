def render_tic_tac_toe_board_to_ascii(board)
  ascii_board = ""

  board.each_with_index do |element, index|
    case element
      when nil then ascii_board << "|   "
      when :x  then ascii_board << "| x "
      when :o  then ascii_board << "| o "
    end
    ascii_board << "|\n" if index % 3 == 2
  end

  ascii_board.chomp
end
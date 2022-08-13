class Board
    attr_accessor :board

    def initialize
        @board = Array.new(8) {Array.new(8, 0)}
        @knight_offsets = knight_offsets()
        @adjacency_list = create_list()
    end

    def knight_offsets
        row_moves = [-1, 1]
        col_moves = [-2, 2]
        valid_moves = row_moves.product(col_moves).concat(col_moves.product(row_moves))
    end

    def create_list
        list = Hash.new
        valid_coord = Array.new(8) {|i| i}
        valid_coord.repeated_permutation(2) {|permutation| list[permutation] = nil}
        print_board()
        list.each {|k, v| list[k] = valid_moves(k)}
    end

    def knight_moves(start, final)
        
    end

    def valid_moves(start)
        # valid_ends = []
        # @knight_offsets.map(start) {|row, column| }
        
        # @board.fetch(row + 1, []).fetch(col + 2, nil)
    end

    def print_board
        @board.each {|row| puts row.join(" ")}
    end
end

test = Board.new
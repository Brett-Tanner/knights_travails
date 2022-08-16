class Board
    attr_accessor :board

    def initialize
        @board = Array.new(8) {Array.new(8, 0)}
        @adjacency_list = create_list()
        @adjacency_list.each {|k, v| puts "#{k}: #{v}"}
        # so first < check always passes
        @min_moves = 65
        @move_list = []
    end

    def knight_offsets
        row_moves = [-1, 1]
        col_moves = [-2, 2]
        valid_moves = row_moves.product(col_moves).concat(col_moves.product(row_moves))
    end

    def valid_moves(start, knight_offsets)
        valid_ends = knight_offsets.map do |offset|
            row = start[0] + offset[0]
            col = start[1] + offset[1] 
            next if row < 0 || row > 7 || col < 0 || col > 7
            [row, col]
        end
        valid_ends.compact
    end

    def create_list
        list = Hash.new
        valid_coord = Array.new(8) {|i| i}
        knight_offsets = knight_offsets()
        valid_coord.repeated_permutation(2) {|permutation| list[permutation] = nil}
        list.each {|k, v| list[k] = valid_moves(k, knight_offsets)}
    end

    def knight_moves(start, fin)
        search_list(start, fin)
        print_solution()
    end

    def search_list(start, fin, temp_list = [start])
        # FIXME: makes moves not in list like 1,6 to 2,3 and 2,3 to 2,5
        @adjacency_list[start].each do |move|
            if temp_list.include?(move)
                puts "Skipped to avoid loop"
                next
            end
            temp_list << move
            if temp_list.length > @min_moves
                puts "skipped as too long"
                next
            end
            puts "Current moves are #{temp_list.length - 1}, temp list is #{temp_list}"
            if move == fin && temp_list.length - 1 < @min_moves
                # -1 because the first space is start, not a move
                @min_moves = temp_list.length - 1
                @move_list = temp_list.dup
                puts "\nNew shortest found!\n"
                puts "\nGlobal moves are #{@min_moves} and global list is #{@move_list}\n"
                next
            end
            search_list(move, fin, temp_list.dup)
        end
    end

    def print_board
        @board.each {|row| puts row.join(" ")}
    end

    def print_solution()
        puts "You can reach #{@move_list.last} from #{@move_list.first} in #{@min_moves} move" if @min_moves < 2
        puts "You can reach #{@move_list.last} from #{@move_list.first} in #{@min_moves} moves" if @min_moves > 1
        puts "Here's your path:"
        @move_list.each {|square| p square}
    end
end

test = Board.new
test.knight_moves([0, 0], [2, 5])
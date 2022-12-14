require 'colorize'

class Board
    attr_accessor :board

    def initialize
        @board = Array.new(8) {Array.new(8, 0)}
        @adjacency_list = create_list()
        start = get_input("start")
        fin = get_input("end")
        knight_moves(start, fin)
    end

    def create_list
        list = Hash.new
        valid_coord = Array.new(8) {|i| i}
        knight_offsets = knight_offsets()
        valid_coord.repeated_permutation(2) {|permutation| list[permutation] = nil}
        list.each {|k, v| list[k] = valid_moves(k, knight_offsets)}
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

    def get_input(string)
        puts "Which row will your knight #{string} on?"
        row = gets.chomp.to_i
        puts "Which column will your knight #{string} on?"
        column = gets.chomp.to_i
        [row, column]
    end

    def knight_moves(start, fin)
        path = search_list(start, fin)
        print_solution(path)
    end

    def search_list(origin, fin, queue = [origin], checked = [origin])
        @adjacency_list[origin].each do |move|
            return [origin, move] if move == fin 
            unless checked.include?(move)
                queue << move
                checked << move
            end
        end
        queue.shift  
        path = search_list(queue[0], fin, queue, checked)
        if @adjacency_list[origin].include?(path[0])
            path.unshift(origin)
        end
        path
    end

    def print_board(board)
        board.each {|row| puts row.join(" ")}
    end

    def print_solution(path)
        puts "You can reach #{path.last} from #{path.first} in #{path.length-1} move" if path.length < 2
        puts "You can reach #{path.last} from #{path.first} in #{path.length-1} moves" if path.length > 1
        puts "Here's your path:"
        path.each {|square| p square}
        puts "Would you like a step by step visualisation?"
        answer = gets.chomp.downcase
        visualise(path) if answer == "y"
        exit(0)
    end

    def visualise(path)
        path.each_index do |step|
            next if step == 0
            puts "From 'k' to 'K'"
            diagram = @board.map {|row| row.dup}
            row = path[step][0]
            col = path[step][1]
            diagram[row][col] = "K".red
            o_row = path[step - 1][0]
            o_col = path[step - 1][1]
            diagram[o_row][o_col] = "k".green
            print_board(diagram)
        end
    end
end

test = Board.new
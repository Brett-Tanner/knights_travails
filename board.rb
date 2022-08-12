class Board
    def initialize
        @board = create_board()
    end

    def create_board
        board = []
        8.times {board << Array.new(8, 0)} 
        board
    end
    
    def knight_moves(start, final)
        
    end
end

test = Board.new
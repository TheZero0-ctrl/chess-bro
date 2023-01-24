class Game < ApplicationRecord
  has_many :playables, dependent: :destroy
  has_many :users, through: :playables

  enum state: {
    in_progress: 'in_progress',
    checkmate: 'checkmate',
    draw: 'draw'
  }

  enum turns: {
    white: 'white',
    black: 'black'
  }

  before_create :set_fen
  before_create :set_pgn

  def set_fen
    turn_abbreviation = turn.white? ? 'w' : 'b'
    self.fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR #{turn_abbreviation} KQkq - 0 1"
  end

  def set_pgn
    self.pgn =
'
[Event "Casual Game"]
[Site "Localhost"]
[Date "01/20/23"]
[EventDate "?"]
[Round "?"]
[Result "1-0"]
[White "?"]
[Black "?"]
[ECO "?"]
[WhiteElo "?"]
[BlackElo "?"]
[PlyCount "?"]
'
  end

  def orientation(user)
    white_player_id == user.id ? 'white' : 'black'
  end
end

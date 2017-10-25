$ ->
  App.chess = new Chess()

  cfg =
    onDrop: (source, target) =>
      move = App.chess.move
        from: source
        to: target
        promotion: "q"

      if (move == null)
        # illegal move
        return "snapback"
      else
        App.game.perform("make_move", move)

  App.board = ChessBoard("chessboard", cfg)
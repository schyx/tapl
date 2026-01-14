module Ch4.Token

public export
data Token
  = TokenTrue
  | TokenFalse
  | TokenZero
  | TokenPred
  | TokenSucc
  | TokenIsZero
  | TokenIf
  | TokenThen
  | TokenElse
  | TokenLeftParen
  | TokenRightParen

export
Show Token where
  show TokenTrue       = "TokenTrue"
  show TokenFalse      = "TokenFalse"
  show TokenZero       = "TokenZero"
  show TokenPred       = "TokenPred"
  show TokenSucc       = "TokenSucc"
  show TokenIsZero     = "TokenIsZero"
  show TokenIf         = "TokenIf"
  show TokenThen       = "TokenThen"
  show TokenElse       = "TokenElse"
  show TokenLeftParen  = "TokenLeftParen"
  show TokenRightParen = "TokenRightParen"

export
Eq Token where
  TokenTrue       == TokenTrue       = True
  TokenFalse      == TokenFalse      = True
  TokenZero       == TokenZero       = True
  TokenPred       == TokenPred       = True
  TokenSucc       == TokenSucc       = True
  TokenIsZero     == TokenIsZero     = True
  TokenIf         == TokenIf         = True
  TokenThen       == TokenThen       = True
  TokenElse       == TokenElse       = True
  TokenLeftParen  == TokenLeftParen  = True
  TokenRightParen == TokenRightParen = True
  _               == _               = False

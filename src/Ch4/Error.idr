module Ch4.Error

import Ch4.Token

public export
data Error : Type where
  ParseError   : List Token -> Error
  ScanError    : String -> Error
  ScanEOFError : Error
  TypeError    : Error

export
Show Error where
  show (ParseError ts) = "ParseError: \{show ts}"
  show (ScanError s)   = "ScanError: \{s}"
  show ScanEOFError    = "ScanEOFError"
  show TypeError       = "TypeError"

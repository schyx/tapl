module Ch4.Term

public export
data Term : Type where
  TermTrue    : Term
  TermFalse   : Term
  TermZero    : Term
  TermPred    : Term -> Term
  TermSucc    : Term -> Term
  TermIsZero  : Term -> Term
  TermTernary : Term -> Term -> Term -> Term

export
isNumeric : Term -> Bool
isNumeric TermZero     = True
isNumeric (TermSucc x) = isNumeric x
isNumeric _            = False

export
isValue : Term -> Bool
isValue TermTrue     = True
isValue TermFalse    = True
isValue x            = isNumeric x

export
Show Term where
  show TermTrue = "true"
  show TermFalse = "false"
  show TermZero = "0"
  show (TermPred t) = "(pred \{show t})"
  show (TermSucc t) = "(succ \{show t})"
  show (TermIsZero t) = "(iszero \{show t})"
  show (TermTernary c t e) = "(if \{show c} then \{show t} else \{show e})"

module Parser

import Data.Fin
import Data.List

public export
record Parser b a where
  constructor MkParser
  runParser : List b -> Maybe (a, List b)

export
Functor (Parser b) where
  map f (MkParser x) = MkParser $ \input =>
    case x input of
         Nothing          => Nothing
         Just (val, rest) => Just (f val, rest)

export
Applicative (Parser b) where
  pure x = MkParser $ \input => Just (x, input)
  (MkParser rpf) <*> (MkParser rpx) = MkParser $ \input =>
    case rpf input of
      Nothing                     => Nothing
      Just (f, intermediateState) =>
        case rpx intermediateState of
          Nothing          => Nothing
          Just (x, output) => Just (f x, output)

export
Monad (Parser b) where
  join (MkParser f) = MkParser $ \input =>
    case f input of
      Nothing                          => Nothing
      Just (MkParser f', intermediate) => f' intermediate

export
Alternative (Parser b) where
  empty = MkParser $ const Nothing
  (MkParser p1) <|> (MkParser p2) =
    MkParser $ \input => p1 input <|> p2 input

mutual
  export
  partial
  some : Parser b a -> Parser b (List a)
  some p = pure (::) <*> p <*> many p

  export
  partial
  many : Parser b a -> Parser b (List a)
  many p = some p <|> pure []

export
pFail : Parser b a
pFail = MkParser $ const Nothing

export
pChar : Char -> Parser Char Char
pChar char = MkParser $ \input =>
  case input of
    (c :: cs) => if c == char then Just (char, cs) else Nothing
    _         => Nothing

export
pSpan : (Char -> Bool) -> Parser Char (List Char)
pSpan pred = MkParser $ \input =>
  let (before, after) := span pred input
   in Just (before, after)

export
pStr : String -> Parser Char String
pStr str = foldlM (\x, y => pChar y *> pure ()) () (unpack str) *> pure str

export
pInt : Parser Char Int
pInt = cast . pack <$> pSpan isDigit

export
pFin : (m : Nat) -> Parser Char (Maybe (Fin m))
pFin m = (\int => integerToFin (cast int) m) <$> pInt

module Ch4.Parser

import Ch4.Error
import Ch4.Term
import Ch4.Token
import Parser

pToken : Token -> Parser Token Token
pToken t = MkParser $ \case
  t1 :: ts => if t == t1 then Just (t, ts) else Nothing
  _        => Nothing

pValue : Parser Token Term
pValue = (pToken TokenTrue *> pure TermTrue)
     <|> (pToken TokenFalse *> pure TermFalse)
     <|> (pToken TokenZero *> pure TermZero)

mutual
  pFunc : Parser Token Term
  pFunc = ((pToken TokenPred *> pure TermPred) <*> pTerm)
      <|> ((pToken TokenSucc *> pure TermSucc) <*> pTerm)
      <|> ((pToken TokenIsZero *> pure TermIsZero) <*> pTerm)

  pIfThenElse : Parser Token Term
  pIfThenElse = TermTernary
            <$> (pToken TokenIf *> pTerm)
            <*> (pToken TokenThen *> pTerm)
            <*> (pToken TokenElse *> pTerm)

  pGrouping : Parser Token Term
  pGrouping = (\a, b, c => b) <$> pToken TokenLeftParen <*> pTerm <*> pToken TokenRightParen

  pTerm : Parser Token Term
  pTerm = pValue <|> pFunc <|> pIfThenElse <|> pGrouping

export
parseTokens : List Token -> Either Error Term
parseTokens tokens = case runParser pTerm tokens of
  Nothing           => Left ScanEOFError
  Just (tokens, []) => Right tokens
  Just (_, s)       => Left $ ParseError s

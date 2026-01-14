module Ch4.Scanner

import Ch4.Error
import Ch4.Token
import Parser

pSpace : Parser Char ()
pSpace = many (pChar ' ') *> pure ()

pToken : Parser Char Token
pToken = (pChar '(' *> pure TokenLeftParen)
     <|> (pChar ')' *> pure TokenRightParen)
     <|> (pack <$> pSpan isAlphaNum >>=
            \case "true"   => pure TokenTrue
                  "false"  => pure TokenFalse
                  "0"      => pure TokenZero
                  "pred"   => pure TokenPred
                  "succ"   => pure TokenSucc
                  "iszero" => pure TokenIsZero
                  "if"     => pure TokenIf
                  "then"   => pure TokenThen
                  "else"   => pure TokenElse
                  _        => pFail
         )

pTokens : Parser Char (List Token)
pTokens = many (pSpace *> pToken <* pSpace)

export
scanInput : String -> Either Error (List Token)
scanInput input = case runParser pTokens (unpack input) of
  Nothing           => Left ScanEOFError
  Just (tokens, []) => Right tokens
  Just (_, s)       => Left $ ScanError $ pack s

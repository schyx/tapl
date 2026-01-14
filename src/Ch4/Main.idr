module Ch4.Main

import Ch4.Error
import Ch4.Eval
import Ch4.Parser
import Ch4.Scanner
import Ch4.Term
import Ch4.Token

import System.REPL

getResult : String -> Either Error Term
getResult input = scanInput input >>= parseTokens >>= evaluate

replFunc : () -> String -> Maybe (String, ())
replFunc () ":q"   = Nothing
replFunc () input  =
  let toShow = case getResult input of
                 Left  err => show err
                 Right val => show val
   in Just (toShow ++ "\n", ())

export
ch4main : IO ()
ch4main = replWith () "> " replFunc

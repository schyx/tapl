module Main

import Ch4.Main
import System

replFunc : List String -> IO ()
replFunc [_, _, "ch4"] = ch4main
replFunc [_, _, _]     = putStrLn "Not yet implemented"
replFunc _             = putStrLn "Wrong number of arguments: Usage is `pack run tapl -- {ch4}"

main : IO ()
main = getArgs >>= replFunc

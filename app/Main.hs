module Main where

import PronXMLParser
import WordIO
import System.Environment

params :: IO ()
params = do
    p <- getArgs
    wrds <- getWords (head p)
    x <- getPronFromXML "deu-eng.tei.txt" wrds
    putWords x (p !! 1)
    return ()

main :: IO ()
main = params

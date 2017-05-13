{-# LANGUAGE OverloadedStrings #-}
module Lib
    (
        getPronFromXML,
        getPronFromXML'
    ) where

import Prelude hiding (readFile)
import Text.XML
import Text.XML.Cursor
import qualified Data.Text as T

{-
getTitle :: String -> IO String
getTitle str = do
    doc <- readFile def "deu-eng.tei.txt"
    let cursor = fromDocument doc
    T.concat $
        cursor >>= descendant >>= element "entry" >>= content
    return "Hello"
-}

matchesString :: [String] -> Cursor -> Bool
matchesString strs cursor = cont `elem` strs
    where cont = T.unpack $ T.concat $ cursor $// content

getPronFromXML :: [String] -> IO [(String, String)]
getPronFromXML strs = do
    doc <- readFile def "deu-eng.tei.txt"
    let cursor = fromDocument doc
    let pron = cursor $/ (extractPron strs) &// content
    let pron_str = map T.unpack pron
    return $ convertToTuples (filter (notElem '\n') pron_str)

extractPron :: [String] -> Cursor -> [Cursor]
extractPron strs cursor =  cursor $// element "orth"
                                 >=> check (matchesString strs)
                                 >=> followingSibling
                                 >=> element "pron"
                                 >=> parent

convertToTuples :: [String] -> [(String, String)]
convertToTuples [] = []
convertToTuples (x:y:z) = (x,y) : convertToTuples z
convertToTuples (x:xs) = (x,x) : []


-- ===================================
-- The code below works but is old
-- code and doesnt work as well
-- ===================================
extractPron' :: String -> Cursor -> [Cursor]
extractPron' str cursor =  cursor $// element "orth"
                                 >=> check (matchesString' str)
                                 >=> followingSibling
                                 >=> element "pron"

matchesString' :: String -> Cursor -> Bool
matchesString' str cursor = if cont == str then True else False
    where cont = T.unpack $ T.concat $ cursor $// content

getPronFromXML' :: String -> IO String
getPronFromXML' str = do
    doc <- readFile def "deu-eng.tei.txt"
    let cursor = fromDocument doc
    let pron = cursor $/ (extractPron' str) &// content
    let pron_str = T.unpack $ T.concat pron
    return pron_str

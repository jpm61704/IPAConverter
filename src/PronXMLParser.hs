{-# LANGUAGE OverloadedStrings #-}
module PronXMLParser
    (
        getPronFromXML
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


{-
checks if a given cursor contains content matching any of the strings in the provided list
-}
matchesString :: [String] -> Cursor -> Bool
matchesString strs cursor = cont `elem` strs
    where cont = T.unpack $ T.concat $ cursor $// content

{-
main function for the library
[String] -> IO [(String, String)]
The first argument is a list(length n) of strings to be searched for
The return value is a list of n 2-tuples containing the strings that were searched and their pronunciation from the xml
-}
getPronFromXML :: String -> [String] -> IO [(String, String)]
getPronFromXML loc strs = do
    doc <- readFile def loc --open the file at loc for reading
    let cursor = fromDocument doc --create a cursor at the head of doc
    let pron = cursor $/ (extractPron strs) &// content --grabs all the content of the nodes within matching entries
    let pron_str = map T.unpack pron --converts these entries to Strings
    return $ convertToTuples (filter (notElem '\n') pron_str) --filters out whitespace and returns tuple-conversions

{-
Extracts entries that match any of the strings in a given list
Once this is done the content from the axis can be extracted
and processed
-}
extractPron :: [String] -> Cursor -> [Cursor]
extractPron strs cursor =  cursor $// element "orth"
                                 >=> check (matchesString strs)
                                 >=> followingSibling
                                 >=> element "pron"
                                 >=> parent

{-
This converts a list of strings to a list of 2 string tuples.
-}
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

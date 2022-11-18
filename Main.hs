{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables  #-}

module Main where

import Control.Monad
import Data.Foldable
import Data.String
import Data.Convertible
import Data.List
import Data.Time.Clock.POSIX
import qualified Data.ByteString.Lazy.Char8 as L8
import qualified Data.ByteString.Char8 as S8
import qualified Data.Yaml as Yaml
import Database.PostgreSQL.Simple
import Network.HTTP.Client.Conduit
import Network.HTTP.Simple
import Data.Aeson (Value)
import Text.HTML.TagSoup
import Text.StringLike(StringLike)


main :: IO ()
main = do
  myParser


data Page = Page { id :: Integer, 
                  title :: String, body :: String, 
                  space_key :: String ,
                  author_id :: Integer, 
                  created_at :: String, 
                  last_updated :: String,
                  parent_id :: Integer}

myParser :: IO ()
myParser = do
  let wikiUrl = "https://en.wikipedia.org/wiki/Main_Page"
  let httpBinUrl = "http://httpbin.org/get"

  response <- httpLBS wikiUrl
  let ctypeHeader = getResponseHeader "Content-Type" response
  let respCode = getResponseStatusCode response
  let respBody = getResponseBody response
--  S8.putStrLn $ Yaml.encode (getResponseBody response :: L8.ByteString)
  let tags = parseTags respBody
  --let divs = filter  (filter isTagOpen tags)
  --let divs = filter isInfixOf "div" ( filter isTagOpen tags )
  --let divs = filter strEq "div" ( filter isTagOpen tags )
  let divs = sections (~== "div") 

  print divs


get_pages_psql :: IO ()
get_pages_psql = do
  conn <- connectPostgreSQL "host=167.235.52.214 dbname= user=dev password="
  pages :: [(String, String)]  <- query_ conn "select title, space_key from pages"  
  mapM_ print pages   
  --for_ [1..10] (print (pages !! 2)
  --for_ pages $ print $ show filterPages
    --where filterPages page = 4 `elem` (fst page)



{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables  #-}

module Main where

import Database.PostgreSQL.Simple
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Control.Monad
import Data.Foldable


main :: IO ()
main = do
  conn <- connectPostgreSQL "host=167.235.52.214 dbname=wiki1 user=devv password=pass"
  pages :: [(String, String)]  <- query_ conn "select title, body from pages"  
  mapM_ pages $ title -> print   
  



  -- HTTP
  manager <- newManager defaultManagerSettings
  request <- parseRequest "http://httpbin.org/get"
  resp <- httpLbs request manager

  putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus resp)
  print $ responseBody resp

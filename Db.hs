
module MyPsql where

import Database.HDBC
import Database.HDBC.PostgreSQL
import Data.Convertible

connectToPsql = do
  conn <- connectPostgreSQL "host=localhost dbname=wiki user=dev password=****"
  select <- prepare conn "SELECT * FROM pages"
  ret <- execute select
  res <- fetchAllRows select
  commit conn
  disconnect conn
  

worked :: IO ()
worked = do
  io <- connectPostgreSQL "host=localhost dbname=mydb user=dev password=****"
  resultIO  <- quickQuery io "select count(*) from pages" []
 -- result <- resultIO
  print resultIO


addRec :: IO ()
addRec = do
  conn <- connectPostgreSQL "host=localhost dbname=mydb user=*** password=***"
  ret <- run conn "INSERT INTO test VALUES (?,?)" [toSql (0::Int), toSql "zero"]
  commit conn
  disconnect conn
  print ("inserted " ++ show ret ++ " records")

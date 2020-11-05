import Control.Monad.Trans.Maybe
import Control.Monad.Trans.Reader
import Control.Monad.Trans.State
import Data.Maybe
import Control.Monad

main = do
        runMaybeT $ kadddr ['a'..'z']
kar :: Show a => [a] -> MaybeT IO a
kar xs = case xs of 
            [] -> MaybeT $ return Nothing                                  
            (x:xs) -> MaybeT $ do{putStrLn (show x); return $ Just x}

kdr :: Show a => [a] -> MaybeT IO [a] 
kdr xs = case xs of
            [] -> MaybeT $ return Nothing
            (x:xs) -> MaybeT $ do{putStrLn (show xs); return $ Just xs}
kadddr = kar <=< kdr <=< kdr <=< kdr

--2
type Parser a = StateT String Maybe a

item :: Parser Char
item = do { x <- get; put $ tail x; return $ head x}

--sat :: (Char -> Bool) -> Parser Char
-- sat pred = do x <- item
--               return $ case (pred x) of
--                             False -> Nothing
--                             True -> x
--string :: String -> Parser String 
--3
type Dictionary = [String]
type Parser' a = ReaderT Dictionary (StateT String Maybe) a

--4
data Btree a = Leaf a | Fork (Btree a)  (Btree a) deriving Show

btree :: (Read a, Show a) => [a] -> String -> Btree a
btree = undefined 
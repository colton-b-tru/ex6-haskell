import Control.Monad.Trans.Maybe


-- 1. Use the MaybeT monad transformer to define functions kar and kdr which work just like
-- car and cdr except that they also print their return value if it is not Nothing.
kar :: Show a => [a] -> MaybeT IO a

kdr :: Show a => [a] -> MaybeT IO [a]





-- 2. Define aParser Char called item that consumes a character.
-- •Define a function called sat that takes a predicate Char−>Bool argument and returns a Parser Char that consumes a character if it satisfies the predicate and fails otherwise.
-- •Define a function called string that takes a String argument and returns a Parser String that consumes a matching string and fails otherwise.
type Parser a = StateT String Maybe a

sat :: (Char -> Bool) -> Parser Char
sat pred = undefined 

string :: String -> Parser String 
string str = undefined 





--3. Define a Parser’ Char called item that consumes a character.
-- •Define a function called sat that takes a predicate Char−>Bool argument and returns a Parser’ Char that consumes a character if it satisfies the predicate and fails otherwise.
-- •Define a function called string that takes a String argument and returns a Parser’ String that consumes a matching string and fails otherwise.
-- •Define a Parser’ String called word which consumes strings in its dictionary and fails for other strings.
type Dictionary = [String]
type Parser’ a = ReaderT Dictionary (StateT String Maybe) a

item :: Parser' Char
item = undefined 

sat ::  (Char -> Bool) -> Parser' Char
sat = undefined 

string :: String -> Parser' String 
string = undefined 

word :: Parser' String 
word = undefined 





--4. Define a function btree :: (Read a, Show a)=>[a]−>String−>Btree a that will construct a Btree a from its printed representation.  
-- The parser should fail if it encounters a word that is not in its dictionary. For example, 
--        > Fork (Leaf 1) (Fork (Fork (Leaf 2) (Leaf 3)) (Leaf 4))
--        Fork (Leaf 1) (Fork (Fork (Leaf 2) (Leaf 3)) (Leaf 4))

data Btree a = Leaf a | Fork (Btree a) (Btree a) deriving Show

btree :: (Read a, Show a) => [a] −> String −> Btree a
btree = undefined 


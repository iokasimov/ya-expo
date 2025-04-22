module Ya.Expo.Instances where

import Ya

import "base" Data.Eq (Eq (..))
import "base" Text.Show (Show (..))
import "base" GHC.Num (Integer, (-), (+))

-- deriving instance Eq i => Eq (I i)
-- deriving instance (Eq l, Eq r) => Eq (l `P` r)
-- deriving instance (Eq l, Eq r) => Eq (l `ML` r)
-- deriving instance Eq Void

deriving instance Show i => Show (I i)
deriving instance (Show l, Show r) => Show (l `P` r)
deriving instance (Show l, Show r) => Show (l `S` r)
deriving instance (Show l, Show r) => Show (U_I_II P l r)
deriving instance (Show l, Show r) => Show (U_I_II S l r)
deriving instance (Show l, Show r) => Show (U_II_I P r l)
deriving instance (Show l, Show r) => Show (U_II_I S r l)
deriving instance Show Void

instance Setoid AR Integer where
 equality (These x y) = if x == y then That y else This (These x y)

instance Setoid AR item => Setoid AR (List item) where
 equality (These x y) = x `lu'ysp` Run y
  `yokl` Forth `ha` Try `ha__` Reach `hu` by None `la` Progress `ha` (`yui` Unit) `ha` equality @AR
  `yi__` Some `hu` This (x `lu` y) `la` Some `hu` That x

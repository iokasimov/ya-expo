module Ya.Expo.Instances where

import Ya

import "base" Data.Eq (Eq (..))
import "base" Text.Show (Show (..))
import "base" GHC.Num (Integer, (-), (+))

-- deriving instance Eq i => Eq (I i)
-- deriving instance (Eq l, Eq r) => Eq (l `LM` r)
-- deriving instance (Eq l, Eq r) => Eq (l `ML` r)
-- deriving instance Eq Void

deriving instance Show i => Show (I i)
deriving instance (Show l, Show r) => Show (l `LM` r)
deriving instance (Show l, Show r) => Show (l `ML` r)
deriving instance (Show l, Show r) => Show (U_I_II LM l r)
deriving instance (Show l, Show r) => Show (U_I_II ML l r)
deriving instance (Show l, Show r) => Show (U_II_I ML r l)
deriving instance (Show l, Show r) => Show (U_II_I LM r l)
deriving instance Show Void

instance Setoid (->) Integer where
 equality (These x y) = if x == y then That y else This (These x y)

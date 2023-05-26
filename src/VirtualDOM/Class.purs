module VirtualDOM.Class where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe)
import Data.Show.Generic (genericShow)
import Data.Tuple.Nested (type (/\))
import Foreign (Foreign)

data Prop a
  = Event String (Foreign -> Maybe a)
  | Attr String String

newtype Key = Key String

newtype ElemName = ElemName String

class Html :: (Type -> Type) -> Constraint
class Functor html <= Html html where
  elem
    :: forall a. ElemName -> Array (Prop a) -> Array (html a) -> html a
  elemKeyed
    :: forall a. ElemName -> Array (Prop a) -> Array (Key /\ html a) -> html a
  text
    :: forall a. String -> html a

class Ctx :: (Type -> Type) -> Type -> Constraint
class Ctx html ctx | html -> ctx where
  withCtx
    :: forall a. (ctx -> html a) -> html a

derive instance Eq ElemName
derive instance Eq Key

derive instance Generic ElemName _
derive instance Generic Key _

instance Show ElemName where
  show = genericShow

instance Show Key where
  show = genericShow


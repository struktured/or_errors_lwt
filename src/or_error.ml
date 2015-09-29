module type S = sig
  module Error : Error.S
  module Result : Result.S
  include Monad.S with type 'a t = ('a, Error.t) Result.t
  val of_result : ('a, Error.t) Result.t -> 'a t
end

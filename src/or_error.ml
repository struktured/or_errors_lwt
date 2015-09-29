module type S =
sig
  module Error : Error.S
  module Result : Result.S
  include Monad.S with type 'a t = ('a, Error.t) Result.t
  val of_result : ('a, Error.t) Result.t -> 'a t
end

module Of_result(Result:Result.S)(Error:Error.S) :
    S with

      module Result = Result and
      module Error = Error =
  struct
      type 'a t = ('a, Error.t) Result.t
      module Error = Error
      module Result = Result
      let map = Result.map
      let bind = Result.bind
      let return = Result.return
      let all = Result.all
      let both = Result.both
      module Infix = Result.Monad_infix
      let of_result t = t
  end

module Create(Or_error:S)(Error:Error.S) = Of_result(Or_error.Result)(Error)



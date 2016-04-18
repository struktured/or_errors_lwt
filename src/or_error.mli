open Or_errors.Std

module type S = 
sig
 include module type of Lwt
 include OR_ERROR with type 'a t := 'a t
end

module Make : functor(Result:RESULT) -> S with module Result = Result

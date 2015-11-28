open Or_errors.Std

module type S = ERROR

module Impl = 
  struct
    type t = exn
    let to_string_hum t = Printexc.to_string t
    let to_string_mach t = to_string_hum t
end

module Signature : S =
struct
module M = Impl
include M
end

include Impl


module Lwt_error = Error
open Or_errors.Std

module Make(Result:RESULT) = struct
  include Lwt
  
  module Error = Lwt_error
  module Result = Result
  module Monad_infix =
  struct
    include Lwt.Infix 
    let (>>|) = (>|=)
  end
  include Monad_infix
  let both = failwith("nyi")
  let ignore t = return @@ Lwt.ignore_result t
  let all = nchoose
  let all_ignore = Lwt.join
  let join = failwith("nyi")
  let map t ~f = map f t
end

module Signature(Result:RESULT) : OR_ERROR = 
struct
  include Make(Result)
end



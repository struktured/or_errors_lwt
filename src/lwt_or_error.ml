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
  let ignore t = return @@ Lwt.ignore_result t
  let all = nchoose
  let all_ignore = Lwt.join
  let join t = Lwt.bind t (fun t' -> Lwt.bind t'
      (fun ok -> Lwt.return ok))
  let both a b = join @@ Lwt.map (fun a -> Lwt.map (fun b -> (a,b)) b) a
  let map t ~f = map f t
  let show a_f t =
    Format.flush_str_formatter() |>
    fun _ -> map ~f:(a_f Format.str_formatter) t
    |> map ~f:Format.flush_str_formatter
  let pp a_f f t = show a_f t |> map ~f:(fun s -> Format.fprintf f "%s" s)
end

module type S =
sig
 include module type of Lwt
 include OR_ERROR with type 'a t := 'a t
end

module Signature(Result:RESULT) : OR_ERROR =
struct
  include Make(Result)
end



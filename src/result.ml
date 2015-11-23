open Or_errors.Std
 
module Impl : RESULT with type ('ok, 'err) t = ('ok, 'err) CCError.t = 
struct
module R = CCError
module Opt = CCOpt
type ('ok, 'err) t = ('ok, 'err) R.t

let ok = function | `Ok t -> Some t | `Error t -> None
let error = function | `Ok _ -> None | `Error t -> Some t
let map x ~f = R.map f x
let bind x f = R.flat_map f x
let return = R.return
let join (t: (('ok, 'err) t, 'err) t) = match t with 
  | (`Ok (`Ok o)) -> `Ok o
  | (`Ok (`Error e)) -> `Error e
  | (`Error _) as e -> e
let map_error t ~f = CCError.map_err f t
let all l =
  let f (t:('ok, 'err) t) =
    match ok t with
      | Some res -> `Ok res
      | None -> `Error (Opt.get_exn (error t)) in
 R.map_l f l
let all_ignore t = map ~f:(fun (t:unit list) -> ()) (all t)
let ignore x = map x ~f:(fun _ ->())
let both x y = 
  match x,y with 
   | `Ok o, `Ok o' -> R.return (o, o')
   | `Ok _, `Error  e -> R.fail e
   | `Error e, _  -> R.fail e
module Monad_infix = struct
  let (>>|) t f = map ~f t
  let (>|=) t f = map ~f t
  let (>>=) t f = bind t f
end
include Monad_infix
end

include Impl

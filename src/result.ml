open Or_errors.Std
 
module Impl : RESULT with type ('ok, 'err) t = ('ok, 'err) CCError.t = struct
module R = CCError
module Opt = CCOpt
type ('ok, 'err) t = ('ok, 'err) R.t

let ok = function | `Ok t -> Some t | `Error t -> None
let error = function | `Ok _ -> None | `Error t -> Some t
let map = R.map
let bind = R.flat_map
let return = R.return
let all l =
  let f (t:('ok, 'err) t) =
    match ok t with
      | Some res -> `Ok res
      | None -> `Error (Opt.get_exn (error t)) in
 R.map_l f l
let both x y = 
  match x,y with 
   | `Ok o, `Ok o' -> R.return (o, o')
   | `Ok _, `Error  e -> R.fail e
   | `Error e, _  -> R.fail e
module Monad_infix = struct
  let (>>|) t f = map f t
  let (>|=) t f = map f t
  let (>>=) t f = bind f t
end
end

include Impl

module type S =
  sig
    type ('ok, 'err) t = Ok of 'ok | Error of 'err 
    val map : ('ok -> 'res) -> ('ok, 'err) t -> ('res, 'err) t
    val bind : ('ok -> ('res, 'err) t) -> ('ok, 'err) t -> ('res, 'err) t
    val return: 'ok -> ('ok, 'err) t
    val all : ('ok, 'err) t list -> ('ok list, 'err) t
    val both : ('a, 'err) t -> ('b, 'err) t -> ('a * 'b, 'err) t

    module Monad_infix :
      sig
        val (>>|) : ('ok, 'err) t -> ('ok -> 'res) -> ('res, 'err) t
        val (>|=) : ('ok, 'err) t -> ('ok -> 'res) ->  ('res, 'err) t
        val (>>=) : ('ok, 'err) t -> ('ok -> ('res, 'err) t) -> ('res, 'err) t
      end
end


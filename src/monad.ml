module type S = 
  sig
    type 'a t
    val map :  ('a -> 'b) -> 'a t -> 'b t
    val bind : ('a -> 'b t) -> 'a t -> 'b t
    val return : 'a -> 'a t
    val all : 'a t list -> 'a list t
    val both : 'a t -> 'b t -> ('a * 'b) t
    module Infix :
      sig
        val (>>|) : 'a t -> ('a -> 'b) -> 'b t
        val (>|=) : 'a t -> ('a -> 'b) -> 'b t
        val (>>=) : 'a t -> ('a -> 'b t) -> 'b t
      end
end

module type S =
sig
  type t
  val to_string_hum : t -> string
  val to_string_mach : t -> string
end


open Or_errors.Std

module type S = ERROR

module Make(T:sig type t [@@deriving show] end) : ERROR = 
  struct
    include T
    let to_string_hum t = show t
    let to_string_mach t = show t
end

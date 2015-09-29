module type S =
sig
  module Error_in : Error.S
  module Error_out : Error.S
  val convert : Error_in.t -> Error_out.t
end

module Identity_error_converter(Error_in:Error.S) : S with
  module Error_in = Error_in and module Error_out = Error_in =
  struct
     module Error_in = Error_in
     module Error_out = Error_in
     let convert (e:Error_in.t) : Error_out.t = e
  end



open Or_errors.Std

module Make(Error:ERROR) : OR_ERROR with module Result = Result = struct
  include Or_errors.Or_error.Of_result
    (Result)(Error)
end


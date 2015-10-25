open Or_errors.Std

include RESULT with type ('ok, 'err) t = ('ok, 'err) CCError.t

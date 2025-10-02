module type Endian = sig
    val p64 : int64 -> string 
    val p32 : int32 -> string
    val p16 : int -> string 
    val p8 : int -> string 
end

module LE : Endian
module BE : Endian

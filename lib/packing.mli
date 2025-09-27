module type Endian = sig
    val p64 : int64 -> char list
    val p32 : int32 -> char list
    val p16 : int -> char list
    val p8 : int -> char list
end

module LE : Endian
module BE : Endian

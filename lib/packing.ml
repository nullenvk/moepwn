module type Endian = sig
    val p64 : int64 -> char list
    val p32 : int32 -> char list
    val p16 : int -> char list
    val p8 : int -> char list
end

let rec pack_nbytes (x : int64) (n : int) (acc : char list) : char list=
    let open Int64 in
    let lastbyte = unsigned_rem x 8L |> to_int |> Char.unsafe_chr in
    if n > 0 
        then pack_nbytes (shift_right x 8) (n - 1) (lastbyte :: acc)
        else acc

module LE : Endian = struct
    let p64 x = pack_nbytes x 8 []
    let p32 x = pack_nbytes (Int64.of_int32 x) 4 []
    let p16 x = pack_nbytes (Int64.of_int x) 2 []
    let p8 x = pack_nbytes (Int64.of_int x) 1 []
end

module BE : Endian = struct
    let p64 x = LE.p64 x |> List.rev
    let p32 x = LE.p32 x |> List.rev
    let p16 x = LE.p16 x |> List.rev
    let p8 x = LE.p8 x |> List.rev
end

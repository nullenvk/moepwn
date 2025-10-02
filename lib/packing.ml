module type Endian = sig
    val p64 : int64 -> string 
    val p32 : int32 -> string
    val p16 : int -> string 
    val p8 : int -> string 
end

let rec pack_nbytes (x : int64) (n : int) (acc : char list) : char list=
    let open Int64 in
    let lastbyte = unsigned_rem x 8L |> to_int |> Char.unsafe_chr in
    if n > 0 
        then pack_nbytes (shift_right x 8) (n - 1) (lastbyte :: acc)
        else acc

let list_to_str (l : char list) : string = List.to_seq l |> String.of_seq

module LE : Endian = struct
    let packn n x = pack_nbytes x n [] |> list_to_str

    let p64 = packn 8
    let p32 x = Int64.of_int32 x |> packn 4
    let p16 x = Int64.of_int x |> packn 2
    let p8 x = Int64.of_int x |> packn 1
end

module BE : Endian = struct
    let packn n x = pack_nbytes x n [] |> List.rev |> list_to_str

    let p64 = packn 8
    let p32 x = Int64.of_int32 x |> packn 4
    let p16 x = Int64.of_int x |> packn 2
    let p8 x = Int64.of_int x |> packn 1
end

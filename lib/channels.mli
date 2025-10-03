(** Bidirectional channel type for communication with the pwned process **)
module type Pwn_Channel = sig
    type handle
    type channel_params

    val open_chan : channel_params -> handle
end

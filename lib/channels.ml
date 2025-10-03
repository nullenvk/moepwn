(** Bidirectional channel type for communication with the pwned process **)
module type Pwn_Channel = sig
    type handle
    type channel_params

    val open_chan : channel_params -> handle
end

module Process_Channel : Pwn_Channel = struct
    type handle = in_channel * out_channel
    type channel_params = {
        process_path : string;
        process_args : string array;
    }

    let open_chan {process_path; process_args} = 
        Unix.open_process_args process_path process_args
end

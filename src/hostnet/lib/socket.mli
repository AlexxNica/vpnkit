(** User-space socket connections *)

module Datagram: sig

  type reply = Cstruct.t -> unit Lwt.t

  val input: reply:reply -> dst:(Ipaddr.V4.t * int) -> payload:Cstruct.t -> unit Lwt.t

end

module Stream: sig
  include Sig.CONN

  val connect_v4: ?read_buffer_size:int -> Ipaddr.V4.t -> int
    -> [ `Ok of flow | `Error of [ `Msg of string ] ] Lwt.t
    (** [connect_v4 addr port] creates a connection to [addr:port] and returns
        the connected flow. *)

  val of_fd: ?read_buffer_size:int -> description:string -> Lwt_unix.file_descr -> flow

end

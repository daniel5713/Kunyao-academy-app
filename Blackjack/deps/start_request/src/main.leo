program start_request.aleo {

    record start_request {
        public owner: address,
        gates: u64,
        signer: address,

        // game_id: u64,
        // request_id: u64,
    }

    transition new_start_reqeust(owner: address) -> start_request {
        return start_request {
            owner: owner,
            gates: 0u64,
            signer: self.caller,
        };
    }

    transition drop_start_request(sr: start_request) {

    }
}

program stand_request.aleo {

    record stand_request {
        public owner: address,
        gates: u64,

        signer: address,
        // game_id: u64,
        // request_id: u64,
    }

    transition new_stand_request(owner: address) -> stand_request {
        return stand_request {
            owner: owner,
            gates: 0u64,
            signer: self.caller
        };
    }

    transition drop_stand_request(sr: stand_request) {

    }
}

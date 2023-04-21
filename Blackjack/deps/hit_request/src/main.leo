program hit_request.aleo {

    record hit_request {
        public owner: address,
        gates: u64,

        signer: address,
        // game_id: u64,
        // request_id: u64,
    }

    transition new_hit_request(owner: address) -> hit_request {
        return hit_request {
            owner: owner,
            gates: 0u64,
            signer: self.caller,
        };
    }
    transition drop_hit_request(sr: hit_request) {
        
    }
}

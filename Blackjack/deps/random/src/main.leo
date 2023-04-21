// The 'random' program.

program random.aleo {
    mapping exists_ids: u64 => u8;

    record part1 {
        public owner: address,
        public gates: u64,

        nonce: u64,
        public id: u64,
        public signer: address,
    }

    record part2 {
        public owner: address,
        public gates: u64,

        nonce: u64,
        public id: u64,
        public signer: address,
    }

    transition exchange(id: u64, nonce: u64, opponent: address) -> (part1, part2) {
        assert(self.caller != opponent);
        assert(nonce != 0u64);
        // part1 is owned by us, and we will initialize nonce privately
        let p1: part1 = part1 {
            owner: self.caller,
            gates: 0u64,
            nonce: nonce,
            id: id,
            signer: self.caller
        };

        // part2 is owned by opponent, and opponent shoud intialize nonce for it, and give it back to us
        let p2: part2 = part2 {
            owner: opponent,
            gates: 0u64,
            // unititialized nonce
            nonce: 0u64,
            id: id,
            signer: self.caller
        };
        return (p1, p2) then finalize(id);
    }
    
    finalize exchange(id: u64) {
        // This will overflow if more than 2 same id created
        increment(exists_ids, id, 255u8);
    }

    // part2 is sent from opponent, and we initialize nonce for it, and give it back to opponent
    transition set_nonce(p2: part2, nonce: u64) -> part2 {
        assert(p2.nonce == 0u64);
        return part2 {
            owner: p2.signer,
            gates: 0u64,
            nonce: nonce,
            id: p2.id,
            signer: self.caller
        };
    }

    transition combine(p1: part1, p2: part2) -> u64 {
        assert(p1.id == p2.id);
        // TODO: Some hash func to generate random number
        return p1.nonce + p2.nonce then finalize(p1.id);
    }

    finalize combine(id: u64) {
        decrement(exists_ids, id, 255u8);
    }
}

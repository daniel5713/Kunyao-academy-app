# Build and Run Guide
### Version

- snarkOS
  - rep: https://github.com/ghostant-1017/snarkOS/tree/hack-deploy
- leo
  - rep: https://github.com/AleoHQ/leo/commit/f30080f6478cbbfa7ea78d58baee0e76061e45ae
- casino
  - rep: https://github.com/TrapedCircuit/zk-casino-server


### Setup

- Use our snarkOS version to build a local chain.

```shell
# Clone the repo
git clone git@github.com:ghostant-1017/snarkOS.git && cd snarkOS

# Checkout the branch and build snarkos
git checkout hack-deploy && cargo build --release

# Run a beacon node
./target/release/snarkos start --beacon "" --nodisplay --dev 0
```

- Build and Deploy the program based on the specific leo version

```shell
# Build
cd zkgaming_blackjack && leo build

# You have to deploy `imports` program first
# In order to deploy zkgaming_blackjack, you have to deploy
# `random.aleo`, `start_request.aleo`, `hit_request.aleo`, `stand_request.aleo`

# Deploy `random.aleo`
cd deps/random && leo build
# In the path of snarkos
cd snarkos && ./target/release/snarkos developer deploy --record "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.public,  gates: 0u64.public,  nonce: 1241243546u64.private,  id: 1546456u64.public,  signer: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.public,  _nonce: 3450485102565810033383928822174690152602695567158297778507599982864522135816group.public}" --query "http://127.0.0.1:3030" --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH --path ../random/build/ --broadcast "http://127.0.0.1:3030/testnet3/transaction/broadcast" --fee 100000000 random.aleo

# Deploy `start_request.aleo`, `hit_request.aleo`, `stand_request.aleo` as above

# Finally, deploy `zkgaming_blackjack.aleo`
# --path: the path of zkgaming_blackjack
# --record: scan record and copy one
./target/release/snarkos developer deploy --record "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.public,  gates: 0u64.public,  nonce: 1241243546u64.private,  id: 1546456u64.public,  signer: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.public,  _nonce: 3450485102565810033383928822174690152602695567158297778507599982864522135816group.public}" --query "http://127.0.0.1:3030" --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH --path ../zkgaming_blackjack/build/ --broadcast "http://127.0.0.1:3030/testnet3/transaction/broadcast" --fee 100000000 zkgaming_blackjack.aleo


```

- Run casino server (this helps the player to read/write the blockchain)

```sh
# 1.build from source
git clone https://github.com/TrapedCircuit/zk-casino-server
cd ./zk-casino-server/casino-server
cargo build --release

# 2. run it.
# --pk: your private key
# --start-at: the block height you want to start at
# --dest: if dest is not set, the base url will be 'http://localhost:3030/testnet3'.
./target/release/casino-server --pk 'your_private_key' --start-at 'block start height'
```

- Run web server

## UI design
We use vue to design UI for liar's dice

### [Install rust](https://rustup.rs/)
``` bash
rustup -V
cargo -V
cargo add wasm-pack
```

### [Install node](https://nodejs.org/en)
``` bash
node -v
v16.13.0
```

### Build wasm
``` bash
git clone git@github.com:abu0306/blackjack-ui.git
cd blackjack-ui/aleo/wasm
wasm-pack build --target web
```

### Install Dependencies
```bash
cd ../sdk && npm i
```
### Change local node's address
Please be aware that you need to use your local node's address to replace the address in this [line](https://github.com/abu0306/blackjack-ui/blob/master/src/App.jsx#L31).


# Implementation

### Run project
```bash
cd ../../blackjack-ui/ && npm i && npm run dev
```

```bash
`./blackjack-ui/src/page/*.jsx`
```
### [Demonstration]()


# Build and Run Guide
### Version

- snarkOS
  - rep: https://github.com/ghostant-1017/snarkOS/tree/hack-deploy
- leo
  - rep: https://github.com/AleoHQ/leo/commit/f30080f6478cbbfa7ea78d58baee0e76061e45ae



### Setup 

- Setup a local chain used our snarkOS version.

```shell
# Clone the repo
git clone git@github.com:ghostant-1017/snarkOS.git && cd snarkOS

# Checkout the branch and build snarkos
git checkout hack-deploy && cargo build --release

# Run a beacon node 
./target/release/snarkos start --beacon "" --nodisplay --dev 0
```

- Build and Deploy the program used the specific leo version

```shell
# Build
cd zkgaming_dicebox && leo build

# In order to deploy `zkgaming_dice.aleo`, you have to deploy `dicebox.aleo` first
./target/release/snarkos developer deploy --record "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.public,  gates: 0u64.public,  nonce: 1241243546u64.private,  id: 1546456u64.public,  signer: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.public,  _nonce: 3450485102565810033383928822174690152602695567158297778507599982864522135816group.public}" --query "http://127.0.0.1:3030" --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH --path ../dicebox/build/ --broadcast "http://127.0.0.1:3030/testnet3/transaction/broadcast" --fee 100000000 dicebox.aleo


# Deploy ( In the snarkOS root)
# --path: the path of zkgaming_dicebox
# --record: scan record and copy one
./target/release/snarkos developer deploy --record "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.public,  gates: 0u64.public,  nonce: 1241243546u64.private,  id: 1546456u64.public,  signer: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.public,  _nonce: 3450485102565810033383928822174690152602695567158297778507599982864522135816group.public}" --query "http://127.0.0.1:3030" --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH --path ../zkgaming_dice/build/ --broadcast "http://127.0.0.1:3030/testnet3/transaction/broadcast" --fee 100000000 zkgaming_dice.aleo

# Scan record
./target/release/snarkos developer scan --endpoint "http://127.0.0.1:3030" --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH --last 100
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
corepack enable
```

### Build wasm
``` bash
git clone git@github.com:lqsbznh/zkgaming-ui.git
cd zkgaming-ui
cd aleo/wasm
wasm-pack build --target web
```

### Install Dependencies
```bash
cd ../sdk && npm i
```

### Run project
```bash
cd ../../zkgaming-ui/ && npm i && npm run dev
```

### Description
`./zkgaming-ui/src/page/.vue`
The game will start from 0 height, if you need to start a new game, you can change currentHeight to the latest height.

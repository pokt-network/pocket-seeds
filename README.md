# pocket-seeds
This repo holds the official lists of seeds for Pocket Mainnet and Testnet.  You can use this information to set up a new node.

Here's an example script to update the seed list in config.json for mainnet.

```bash
export SEEDS=$(curl -s "https://raw.githubusercontent.com/pokt-network/pocket-seeds/main/mainnet.txt" | tr '\n' ',' | sed 's/,*$//')
sed -i 's/"Seeds":.*$/"Seeds": "'${SEEDS}'",/' ${HOME}/.pocket/config/config.json
```


# pocket-seeds <!-- omit in toc -->

This repo holds the official lists of seeds for Pocket Mainnet and Testnet.

You can use this information to set up a new node.

- [MainNet Helpers](#mainnet-helpers)
  - [Update Config](#update-config)
  - [Echo MainNet Seeds](#echo-mainnet-seeds)
- [TestNet Helpers](#testnet-helpers)
  - [Echo TestNet Seeds](#echo-testnet-seeds)

## MainNet Helpers

### Update Config

Here's an example script to update the seed list in config.json for mainnet.

```bash
export SEEDS=$(curl -s "https://raw.githubusercontent.com/pokt-network/pocket-seeds/main/mainnet.txt" | tr '\n' ',' | sed 's/,*$//')
sed -i 's/"Seeds":.*$/"Seeds": "'${SEEDS}'",/' ${HOME}/.pocket/config/config.json
```

### Echo MainNet Seeds

```bash
echo $(curl -s "https://raw.githubusercontent.com/pokt-network/pocket-seeds/main/mainnet.txt" | tr '\n' ',' | sed 's/,*$//')
```

## TestNet Helpers

### Echo TestNet Seeds

```bash
echo $(curl -s "https://raw.githubusercontent.com/pokt-network/pocket-seeds/main/testnet.txt" | tr '\n' ',' | sed 's/,*$//')
```

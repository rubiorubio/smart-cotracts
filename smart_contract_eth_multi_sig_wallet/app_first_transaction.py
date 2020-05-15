#%%
from web3 import Web3
# connect to ganache
ganache_url = "http://127.0.0.1:7545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

# print(web3.isConnected())
# print(web3.eth.blockNumber)

account_1 = "0x7926Aaff4FCD9136aaa60028922412D22646378E"
account_2 = "0xded6FefE2EE5Ffd3f47f0ef8EcBd31e7Ad3746Ba"

private_key_1 = "cb26ee529f16fef3f5d8fec7761538230a3e5cb6a44313d3f3f1326b6ff5ff02"

# get nonce
nonce = web3.eth.getTransactionCount(account_1)
# get a nonce (number that can only be used once)
# build a transaction
tx = {
    'nonce'   : nonce,
    'to'      : account_2,
    'value'   : web3.toWei(19,'ether'),
    'gas'     : 2000000,
    'gasPrice': web3.toWei('50','gwei')

}
# sign transaction
signed_tx = web3.eth.account.signTransaction(tx, private_key_1)

# send transaction
tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
print(web3.toHex(tx_hash))
# get transaction hash

# %%
79218844926
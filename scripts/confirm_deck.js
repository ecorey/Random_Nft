import { getFullnodeUrl, SuiClient, SuiHTTPTransport  } from "@mysten/sui.js/client";
import { Ed25519Keypair } from "@mysten/sui.js/keypairs/ed25519";
import { TransactionBlock } from "@mysten/sui.js/transactions";
import walletDev from './dev-wallet.json' assert { type: 'json' };

import { WebSocket } from 'ws';

import {  Package  } from './config.js';






// generate a keypair
const privateKeyArray = walletDev.privateKey.split(',').map(num => parseInt(num, 10));
const privateKeyBytes = new Uint8Array(privateKeyArray);
const keypairdev = Ed25519Keypair.fromSecretKey(privateKeyBytes);


const DEVNET_URL = "https://fullnode.devnet.sui.io:443"; 



// client
const client = new SuiClient({
    transport: new SuiHTTPTransport({
        // url: getFullnodeUrl('testnet'),
        url: DEVNET_URL,
        WebSocketConstructor: WebSocket
    }),
});




(async () => {
    try {
     
        
        // create Transaction Block
        const txb = new TransactionBlock();


        txb.setGasBudget(10000000);


        const GENERAL= "";
        const MONSTER= "";
        const RIDER= "";
        const SOLDIER= "";


        async function confirmDeck() {
            await txb.moveCall({
                target: `${Package}::card_deck::confirm_deck`,
                arguments: [txb.object(GENERAL), txb.object(MONSTER), txb.object(RIDER), txb.object(SOLDIER)],
            });
           
        }

        await confirmDeck();
        
        


        
        // finalize the transaction block
        let txid = await client.signAndExecuteTransactionBlock({
            signer: keypairdev,
            transactionBlock: txb,
        });
        


        // // log the transaction result
        console.log(`Transaction result: ${JSON.stringify(txid, null, 2)}`);
        console.log(`success: https://suiexplorer.com/txblock/${txid.digest}?network=testnet`);



        console.log(`END OF SCRIPT`);

    } catch (e) {
        console.error(`error: ${e}`);
    }
})();





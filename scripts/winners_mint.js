import { getFullnodeUrl, SuiClient, SuiHTTPTransport  } from "@mysten/sui.js/client";
import { Ed25519Keypair } from "@mysten/sui.js/keypairs/ed25519";
import { TransactionBlock } from "@mysten/sui.js/transactions";
import walletDev from './dev-wallet.json' assert { type: 'json' };

import { WebSocket } from 'ws';

import {  Package, RANDOM  } from './config.js';




// NEED TO BE ON DEVNET




// generate a keypair
const privateKeyArray = walletDev.privateKey.split(',').map(num => parseInt(num, 10));
const privateKeyBytes = new Uint8Array(privateKeyArray);
const keypairdev = Ed25519Keypair.fromSecretKey(privateKeyBytes);


const PLECO_TREASURY_CAP = "0xc80242ee50d2219400a8ead664db10ffcf28996d8c3a915673007180c7519470";
const TROPHY = "0x86969bcb6787976704f2c88887b4fb5993bbdeb6e39faa8ec46a486719b02e05";





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




        txb.moveCall({
            target: `${Package}::card_deck::winner_mint`,
            arguments: [
                txb.object(PLECO_TREASURY_CAP),
                txb.object(TROPHY),
            ],
        });
        
       
        


        // Finalize the transaction block
        let txid = await client.signAndExecuteTransactionBlock({
            signer: keypairdev,
            transactionBlock: txb,
        });


        // Log the transaction result
        console.log(`Transaction result: ${JSON.stringify(txid, null, 2)}`);
        console.log(`success`);

        console.log(`END OF SCRIPT`);

    } catch (e) {
        console.error(`error: ${e}`);
    }
})();

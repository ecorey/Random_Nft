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


const PLECO_TREASURY_CAP = "0xace53f11c6a1c2c46a3cc09ed398a549fa8e370e35b34d1c116e05ecaf888ded";
const TROPHY = "0xd1f05c78071d461f18ea6b7e24d2962a1b524b5ac5b0e186072e34cb35859e87";





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
            target: `${Package}::card_deck::treasurer_mint_to_winner`,
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

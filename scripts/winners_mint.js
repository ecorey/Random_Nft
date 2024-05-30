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


const PLECO_TREASURY_CAP = "0x5218d5f77ce05d86297b52239632f7bfe92e2d78658b8e706789852caf54cde3";
const TROPHY = "0x8b04360023f57a12af5f09276a534f7048637efd0311427edf1ebd0fd530ba5e";
const RECIPIENT = "0x707395068fdb96fa34e1d3376386d70bbca4c66829e89b285b4a43a4ce1ffa79";




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
                txb.pure.address(RECIPIENT),
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

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

        const RANDOM = "0x8";
        
        const SOLDIER_GNOME_ATTACK= "0x5a96cc31ea87ad3d509e1429e4537a19d70f646e3be3da3bcd2ecef63fb040c5";
        const CONFIRMED_GNOME_DECK = "0x865f265e9a69cf7b02a2b02b92188e2cc7a1cc71ed20f65cf9838f775dccfcb3";

        const SOLDIER_CAPY_DEFEND= "0xc37bab69741a1ad6c76ec7537d50aa7f5e60d9bef0c4382cde8a52dd21d9e552";
        const CONFIRMED_CAPY_DECK = "0xc4a11bf379618a0601d7a10005b88ae212f74d1c024a702d3f62b5f66f5637f2";




        async function soldierVsSoldier() {
            await txb.moveCall({
                target: `${Package}::card_deck::soldier_vs_soldier`,
                arguments: [txb.object(RANDOM), txb.object(SOLDIER_GNOME_ATTACK), txb.object(CONFIRMED_GNOME_DECK), txb.object(SOLDIER_CAPY_DEFEND), txb.object(CONFIRMED_CAPY_DECK)],
            });
           
        }



        await soldierVsSoldier();
        
        


        
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





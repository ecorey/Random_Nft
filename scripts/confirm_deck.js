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


        const GENERAL= "0x71dae9330f3d25c809f557fe025e315c927e38e88f8978bb94996dfdaec23b9d";
        const MONSTER= "0xcb37a1865be375a8735a5ebc76b829c9ffbf65a304b0f12d21b081d9abaf3b22";
        const RIDER= "0xc09cd546e8c1f0d565b08d3d25a436b8375c01e2eeffe0898c13ca713e804160";
        const SOLDIER= "0xc37bab69741a1ad6c76ec7537d50aa7f5e60d9bef0c4382cde8a52dd21d9e552";


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





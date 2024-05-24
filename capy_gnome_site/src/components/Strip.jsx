import React from 'react';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';

import { useNavigate } from 'react-router-dom';


const Strip = () => {
    const { signAndExecuteTransactionBlock } = useWallet();
    
    const navigate = useNavigate(); // Initialize navigate function


    const handleTransferCapyDeck = () => transferCapyDeck(signAndExecuteTransactionBlock);
    const handleTransferGnomeDeck = () => transferGnomeDeck(signAndExecuteTransactionBlock);

    const handleConfirmDeck = () => {
        navigate('/confirm');  
    };

    const handleStartGame = () => {
        navigate('/start');  
    };


    const handleGameConfig = () => {
        navigate('/gameconfiguration');  
    };



    return (
        <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            backgroundColor: '#232323',
            width: '60%',
            padding: '40px 19vw',  
            paddingTop: '75px',
            fontFamily: 'pixelify sans'
        }}>
            <div style={{
                display: 'flex',
                gap: '55px',
            }}>  
                <button style={buttonStyle} onClick={handleTransferCapyDeck}>MINT CAPY DECK</button>
                <button style={buttonStyle} onClick={handleTransferGnomeDeck}>MINT GNOME DECK</button>
            
                <div style={{ flexGrow: 1 }}></div> 
            <button style={buttonStyle} onClick={handleConfirmDeck}>CONFIRM DECK</button>
            <button style={buttonStyle} onClick={handleStartGame}>START GAME</button>
            <button style={buttonStyle} onClick={handleGameConfig}>GAME CONFIG</button>
            </div>
            
        </div>
    );
};

const buttonStyle = {
    background: 'none',
    color: 'white',
    border: 'none',
    padding: '10px',
    fontSize: '20px',
    cursor: 'pointer',
    outline: 'none'
};

export default Strip;

async function transferCapyDeck(signAndExecuteTransactionBlock) {
    const txb = new TransactionBlock();
    txb.setGasBudget(1000000000);
    txb.moveCall({
        target: `${Package}::card_deck::mint_capy_cards`,
        arguments: [],
    });

    try {
        const capyDeckData = await signAndExecuteTransactionBlock({
            transactionBlock: txb
        });
        console.log('Capy Deck Transferred!', capyDeckData);
        alert(`Congrats! Capy Deck Transferred! \n Digest: ${capyDeckData.digest}`);
    } catch (e) {
        console.error('Sorry, Capy Deck Was Not Transferred!', e);
    }
}

async function transferGnomeDeck(signAndExecuteTransactionBlock) {
    const txb = new TransactionBlock();
    txb.setGasBudget(1000000000);
    txb.moveCall({
        target: `${Package}::card_deck::mint_gnome_cards`,
        arguments: [],
    });

    try {
        const gnomeDeckData = await signAndExecuteTransactionBlock({
            transactionBlock: txb
        });
        console.log('Gnome Deck Transferred!', gnomeDeckData);
        alert(`Congrats! Gnome Deck Transferred! \n Digest: ${gnomeDeckData.digest}`);
    } catch (e) {
        console.error('Sorry, Gnome Deck Was Not Transferred!', e);
    }
}

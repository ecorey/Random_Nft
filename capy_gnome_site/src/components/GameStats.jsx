import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { useWallet } from '@suiet/wallet-kit';
import { Package } from '../../../scripts/config';



const GameStats = () => {
    const navigate = useNavigate();
    const { signAndExecuteTransactionBlock } = useWallet();

    const gameSetup = JSON.parse(localStorage.getItem('gameSetup')) || { game: "Not set", turnkey: "Not set" };
    const GAME = gameSetup.game;
    const TurnKey = gameSetup.turnkey;


 


    const gameStats = async () => {
        setLoading(true);
        setError(null);
        const txb = new TransactionBlock();
        txb.setGasBudget(1000000000);

       

        // Emit the event
        txb.moveCall({
            target: `${Package}::card_deck::emit_game_stats_event`,
            arguments: [txb.object(GAME)],
        });

        const result = await signAndExecuteTransactionBlock({ transactionBlock: txb });
        console.log('Event emitted!', result);

        
    };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Game Stats</h1>
            <p>game: {GAME || "Not set"}</p>
            <p>turn key: {TurnKey || "Not set"}</p>

            
            <button onClick={gameStats} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>GET STATS</button>
            <button onClick={() => navigate('/')} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>Home</button>
        </div>
    );
};

export default GameStats;

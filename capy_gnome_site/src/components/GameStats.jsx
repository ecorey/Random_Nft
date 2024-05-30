import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { useWallet } from '@suiet/wallet-kit';
import { Package } from '../../../scripts/config';

const gameSetup = JSON.parse(localStorage.getItem('gameSetup')) || { game: "Not set", turnkey: "Not set" };
const GAME = gameSetup.game;

const GameStats = () => {
    const navigate = useNavigate();
    const { signAndExecuteTransactionBlock } = useWallet();
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);

    const gameStats = async () => {
        setLoading(true);
        setError(null);
        const txb = new TransactionBlock();
        txb.setGasBudget(1000000000);

        console.log("GAME:", GAME);

        try {
            // Emit the event
            txb.moveCall({
                target: `${Package}::card_deck::emit_game_stats_event`,
                arguments: [txb.object(GAME)],
            });

            const result = await signAndExecuteTransactionBlock({ transactionBlock: txb });
            console.log('Event emitted!', result);
        } catch (err) {
            console.error('Error while emitting event:', err);
            setError(err.message || 'Failed to emit event');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Game Stats</h1>
            {loading ? <p>Loading...</p> : null}
            {error ? <p style={{ color: 'red' }}>Error: {error}</p> : null}
            <button onClick={gameStats} style={buttonStyle}>GET STATS</button>
            <button onClick={() => navigate('/')} style={buttonStyle}>Home</button>
        </div>
    );
};

const buttonStyle = {
    width: '100%',
    padding: '10px',
    marginTop: '20px',
    backgroundColor: 'blue',
    color: 'white',
    fontSize: '16px',
    border: 'none',
    cursor: 'pointer'
};

export default GameStats;

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

    const [stats, setStats] = useState({
        coin_flip_guess: "Not set",
        coin_flip_count: "Not set",
        coin_flip_result: "Not set",
    });

    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);

    const gameStats = async () => {
        setLoading(true);
        setError(null);
        const txb = new TransactionBlock();
        txb.setGasBudget(1000000000);

        try {
            const coin_flip_guess_result = await txb.moveCall({
                target: `${Package}::card_deck::coin_flip_guess`,
                arguments: [txb.object(GAME)],
            });

            const coin_flip_count_result = await txb.moveCall({
                target: `${Package}::card_deck::coin_flip_count`,
                arguments: [txb.object(GAME)],
            });

            const coin_flip_result_result = await txb.moveCall({
                target: `${Package}::card_deck::coin_flip_result`,
                arguments: [txb.object(GAME)],
            });

            console.log('coin_flip_guess_result:', coin_flip_guess_result);
            console.log('coin_flip_count_result:', coin_flip_count_result);
            console.log('coin_flip_result_result:', coin_flip_result_result);

            // Update the stats with the new values
            setStats({
                coin_flip_guess: coin_flip_guess_result.returnValues ? coin_flip_guess_result.returnValues[0] : "Not set",
                coin_flip_count: coin_flip_count_result.returnValues ? coin_flip_count_result.returnValues[0] : "Not set",
                coin_flip_result: coin_flip_result_result.returnValues ? coin_flip_result_result.returnValues[0] : "Not set",
            });

            // Emit the event
            txb.moveCall({
                target: `${Package}::card_deck::emit_game_stats_event`,
                arguments: [txb.object(GAME)],
            });

            const result = await signAndExecuteTransactionBlock({ transactionBlock: txb });
            console.log('Event emitted!', result);
        } catch (error) {
            console.error('Error emitting event:', error);
            setError("Error emitting event: " + error.message);
            setStats({
                coin_flip_guess: "Error",
                coin_flip_count: "Error",
                coin_flip_result: "Error",
            });
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Game Stats</h1>
            <p>game: {GAME || "Not set"}</p>
            <p>turn key: {TurnKey || "Not set"}</p>

            <h1>Coin Data</h1>
            {loading ? (
                <p>Loading...</p>
            ) : error ? (
                <p>{error}</p>
            ) : (
                <>
                    <p>coin_flip_result: {stats.coin_flip_result}</p>
                    <p>coin_flip_guess: {stats.coin_flip_guess}</p>
                    <p>coin_flip_count: {stats.coin_flip_count}</p>
                </>
            )}

            <button onClick={gameStats} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>GET STATS</button>
            <button onClick={() => navigate('/')} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>Home</button>
        </div>
    );
};

export default GameStats;

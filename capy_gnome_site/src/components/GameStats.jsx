// UNDER CONSTRUCTION\

// MOVE CALL THEN UPDATE

import React, { useEffect, useState } from 'react';
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
    const PACKAGE_ID = '0x41391e2d4c014356eaffda8fc909760eae8f0569bd468acaa518ab5e53de4c86'; 
    const MODULE_ID = 'card_deck'; 

    const [stats, setStats] = useState({
        coin_flip_guess: "Not set",
        coin_flip_count: "Not set",
        coin_flip_result: "Not set",
    });

    // const gameStats = async () => {
    //     const txb = new TransactionBlock();

    //     txb.setGasBudget(1000000000);

    //     const coin_flip_guess_result = await txb.moveCall({
    //         target: `${Package}::card_deck::coin_flip_guess`,
    //         arguments: [txb.object(GAME)],
    //     });

    //     const coin_flip_count_result = await txb.moveCall({
    //         target: `${Package}::card_deck::coin_flip_count`,
    //         arguments: [txb.object(GAME)],
    //     });

    //     const coin_flip_result_result = await txb.moveCall({
    //         target: `${Package}::card_deck::coin_flip_result`,
    //         arguments: [txb.object(GAME)],
    //     });

    //     setStats({
    //         coin_flip_guess: coin_flip_guess_result || "Not set",
    //         coin_flip_count: coin_flip_count_result || "Not set",
    //         coin_flip_result: coin_flip_result_result || "Not set",
    //     });

    //     try {
    //         const result = await signAndExecuteTransactionBlock({ transactionBlock: txb });
    //         console.log('Event emitted!', result);
    //         return result;
    //     } catch (error) {
    //         console.error('Error emitting event:', error);
    //         throw error;
    //     }
    // };



    // useEffect(() => {
    //     const getGameStats = async () => {
    //         try {
    //             await gameStats();
    //         } catch (error) {
    //             console.error('Error during getGameStats:', error);
    //         }
    //     };

    //     if (GAME !== "Not set") {
    //         getGameStats();
    //     }
    // }, [GAME]);




    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Game Stats</h1>
            <p>game: {GAME || "Not set"}</p>
            <p>turn key: {TurnKey || "Not set"}</p>

            {/* <h1>Coin Data</h1>
            <p>coin_flip_result: {stats.coin_flip_result}</p>
            <p>coin_flip_guess: {stats.coin_flip_guess}</p>
            <p>coin_flip_count: {stats.coin_flip_count}</p> */}
            
            {/* <button onClick={() => gameStats()} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>GET STATS</button> */}

            <button onClick={() => navigate('/')} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>Home</button>
        </div>
    );
};

export default GameStats;











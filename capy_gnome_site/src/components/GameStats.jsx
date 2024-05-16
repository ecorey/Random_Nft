// UNDER CONSTRUCTION\

// MAYBE MOVE CALL THEN UPDATE



import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { useWallet } from '@suiet/wallet-kit';
import { useSuiClientQuery } from '@mysten/dapp-kit';
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
        player_one_address: "Not set",
        player_two_address: "Not set",
        coin_flip_guess: "Not set",
        coin_flip_count: "Not set",
        coin_flip_result: "Not set",
        even_turns: "Not set",
        odd_turns: "Not set",
        turn_count: "Not set",
        confirm_deck_player_one: "Not set",
        confirm_deck_player_two: "Not set",
        player_one_general_status: "Not set",
        player_one_monster_status: "Not set",
        player_one_rider_status: "Not set",
        player_one_soldier_status: "Not set",
        player_two_general_status: "Not set",
        player_two_monster_status: "Not set",
        player_two_rider_status: "Not set",
        player_two_soldier_status: "Not set",
    });

    const emitEvent = async () => {
        const txb = new TransactionBlock();
        txb.setGasBudget(1000000000);

        txb.moveCall({
            target: `${Package}::card_deck::emit_game_stats_event`,
            arguments: [txb.object(GAME)],
        });

        try {
            const result = await signAndExecuteTransactionBlock({ transactionBlock: txb });
            console.log('Event emitted!', result);
            return result;
        } catch (error) {
            console.error('Error emitting event:', error);
            throw error;
        }
    };

    const fetchGameStats = async () => {
        try {
            const result = await useSuiClientQuery(
                'suix_queryEvents',
                {
                    MoveModule: {
                        package: PACKAGE_ID,
                        module: MODULE_ID
                    },
                    limit: 100,
                    descending_order: true,
                }
            );

            if (result.data.length > 0) {
                const latestEvent = result.data[0].parsedJson; // Get the latest event
                setStats({
                    player_one_address: latestEvent.player_one_address || "Not set",
                    player_two_address: latestEvent.player_two_address || "Not set",
                    coin_flip_guess: latestEvent.coin_flip_guess || "Not set",
                    coin_flip_count: latestEvent.coin_flip_count || "Not set",
                    coin_flip_result: latestEvent.coin_flip_result || "Not set",
                    even_turns: latestEvent.even_turns || "Not set",
                    odd_turns: latestEvent.odd_turns || "Not set",
                    turn_count: latestEvent.turn_count || "Not set",
                    confirm_deck_player_one: latestEvent.confirm_deck_player_one || "Not set",
                    confirm_deck_player_two: latestEvent.confirm_deck_player_two || "Not set",
                    player_one_general_status: latestEvent.player_one_general_status || "Not set",
                    player_one_monster_status: latestEvent.player_one_monster_status || "Not set",
                    player_one_rider_status: latestEvent.player_one_rider_status || "Not set",
                    player_one_soldier_status: latestEvent.player_one_soldier_status || "Not set",
                    player_two_general_status: latestEvent.player_two_general_status || "Not set",
                    player_two_monster_status: latestEvent.player_two_monster_status || "Not set",
                    player_two_rider_status: latestEvent.player_two_rider_status || "Not set",
                    player_two_soldier_status: latestEvent.player_two_soldier_status || "Not set",
                });
            }
        } catch (error) {
            console.error('Error fetching game stats events:', error);
        }
    };

    useEffect(() => {
        const getGameStats = async () => {
            try {
                await emitEvent();
                await fetchGameStats();
            } catch (error) {
                console.error('Error during getGameStats:', error);
            }
        };

        if (GAME !== "Not set") {
            getGameStats();
        }
    }, [GAME]);

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Game Stats</h1>
            <p>game: {GAME || "Not set"}</p>
            <p>turn key: {TurnKey || "Not set"}</p>

            <h1>Player addresses</h1>
            <p>player_one_address: {stats.player_one_address}</p>
            <p>player_two_address: {stats.player_two_address}</p>

            <h1>Coin Data</h1>
            <p>coin_flip_result: {stats.coin_flip_result}</p>
            <p>coin_flip_guess: {stats.coin_flip_guess}</p>
            <p>coin_flip_count: {stats.coin_flip_count}</p>
            
            <h1>Game Turn Data</h1>
            <p>even_turns: {stats.even_turns}</p>
            <p>odd_turns: {stats.odd_turns}</p>
            <p>turn_count: {stats.turn_count}</p>

            <h1>Game Confirmed Decks Data</h1>
            <p>confirm_deck_player_one: {stats.confirm_deck_player_one}</p>
            <p>confirm_deck_player_two: {stats.confirm_deck_player_two}</p>

            <h1>Player Card Data 1</h1>
            <p>player_one_general_status: {stats.player_one_general_status}</p>
            <p>player_one_monster_status: {stats.player_one_monster_status}</p>
            <p>player_one_rider_status: {stats.player_one_rider_status}</p>
            <p>player_one_soldier_status: {stats.player_one_soldier_status}</p>

            <h1>Player Card Data 2</h1>
            <p>player_two_general_status: {stats.player_two_general_status}</p>
            <p>player_two_monster_status: {stats.player_two_monster_status}</p>
            <p>player_two_rider_status: {stats.player_two_rider_status}</p>
            <p>player_two_soldier_status: {stats.player_two_soldier_status}</p>

            <button onClick={() => navigate('/')} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>Home</button>
        </div>
    );
};

export default GameStats;

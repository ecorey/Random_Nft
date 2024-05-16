// UNDER CONSTRUCTION
// QUERY AND DISPLAY THE GAME DATA
// (or through move calls?) 

import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext';
import fetchGameStats from './suiRpcClient';

const GameStats = () => {
    const navigate = useNavigate();
    const { player1, player2 } = useCardContext();
    const gameSetup = JSON.parse(localStorage.getItem('gameSetup')) || { game: "Not set", turnkey: "Not set" };
    const GAME = gameSetup.game;
    const TurnKey = gameSetup.turnkey;

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

    useEffect(() => {
        const getGameStats = async () => {
            try {
                const gameStats = await fetchGameStats(GAME);
                setStats({
                    player_one_address: gameStats.player_one_address || "Not set",
                    player_two_address: gameStats.player_two_address || "Not set",
                    coin_flip_guess: gameStats.coin_flip_guess || "Not set",
                    coin_flip_count: gameStats.coin_flip_count || "Not set",
                    coin_flip_result: gameStats.coin_flip_result || "Not set",
                    even_turns: gameStats.even_turns || "Not set",
                    odd_turns: gameStats.odd_turns || "Not set",
                    turn_count: gameStats.turn_count || "Not set",
                    confirm_deck_player_one: gameStats.confirm_deck_player_one || "Not set",
                    confirm_deck_player_two: gameStats.confirm_deck_player_two || "Not set",
                    player_one_general_status: gameStats.player_one_general_status || "Not set",
                    player_one_monster_status: gameStats.player_one_monster_status || "Not set",
                    player_one_rider_status: gameStats.player_one_rider_status || "Not set",
                    player_one_soldier_status: gameStats.player_one_soldier_status || "Not set",
                    player_two_general_status: gameStats.player_two_general_status || "Not set",
                    player_two_monster_status: gameStats.player_two_monster_status || "Not set",
                    player_two_rider_status: gameStats.player_two_rider_status || "Not set",
                    player_two_soldier_status: gameStats.player_two_soldier_status || "Not set",
                });
            } catch (error) {
                console.error('Error fetching game stats:', error);
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

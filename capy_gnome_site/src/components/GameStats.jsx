import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext'; 
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';

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

    const handleGameStats = async () => {

        const txb = new TransactionBlock();
        
        txb.setGasBudget(1000000000);

        const calls = [
            { target: `${Package}::card_deck::player_one_address`, stateKey: 'player_one_address' },
            { target: `${Package}::card_deck::player_two_address`, stateKey: 'player_two_address' },
            { target: `${Package}::card_deck::coin_flip_guess`, stateKey: 'coin_flip_guess' },
            { target: `${Package}::card_deck::coin_flip_count`, stateKey: 'coin_flip_count' },
            { target: `${Package}::card_deck::coin_flip_result`, stateKey: 'coin_flip_result' },
            { target: `${Package}::card_deck::even_turns`, stateKey: 'even_turns' },
            { target: `${Package}::card_deck::odd_turns`, stateKey: 'odd_turns' },
            { target: `${Package}::card_deck::turn_count`, stateKey: 'turn_count' },
            { target: `${Package}::card_deck::confirm_deck_player_one`, stateKey: 'confirm_deck_player_one' },
            { target: `${Package}::card_deck::confirm_deck_player_two`, stateKey: 'confirm_deck_player_two' },
            { target: `${Package}::card_deck::player_one_general_status`, stateKey: 'player_one_general_status' },
            { target: `${Package}::card_deck::player_one_monster_status`, stateKey: 'player_one_monster_status' },
            { target: `${Package}::card_deck::player_one_rider_status`, stateKey: 'player_one_rider_status' },
            { target: `${Package}::card_deck::player_one_soldier_status`, stateKey: 'player_one_soldier_status' },
            { target: `${Package}::card_deck::player_two_general_status`, stateKey: 'player_two_general_status' },
            { target: `${Package}::card_deck::player_two_monster_status`, stateKey: 'player_two_monster_status' },
            { target: `${Package}::card_deck::player_two_rider_status`, stateKey: 'player_two_rider_status' },
            { target: `${Package}::card_deck::player_two_soldier_status`, stateKey: 'player_two_soldier_status' },
        ];

        try {
            const gameData = await signAndExecuteTransactionBlock({ transactionBlock: txb });
            console.log('Game Stats!', gameData);
            alert(`Congrats! Game Stats! \n Digest: ${gameData.digest}`);
        } catch (e) {
            console.error('Sorry, Game Stats NOT returned', e);
        }
    };



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

            <button onClick={handleGameStats} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>
                Fetch Game Stats
            </button>
            <button onClick={() => navigate('/')} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>Home</button>
        </div>
    );
};

export default GameStats;

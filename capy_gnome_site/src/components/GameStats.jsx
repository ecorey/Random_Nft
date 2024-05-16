import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext'; 
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';

const GameStats = () => {
    const navigate = useNavigate();
    const { player1, player2 } = useCardContext(); 
    const gameSetup = JSON.parse(localStorage.getItem('gameSetup')) || { game: "Not set", turnkey: "Not set" };
    const GAME = gameSetup.game; // Get the game configuration

    const handleGameStats = async () => {
        const txb = new TransactionBlock();
        txb.setGasBudget(1000000000);

        let player_one_address = txb.moveCall({
            target: `${Package}::card_deck::player_one_address`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let player_two_address = txb.moveCall({
            target: `${Package}::card_deck::player_two_address`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let coin_flip_guess = txb.moveCall({
            target: `${Package}::card_deck::coin_flip_guess`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let coin_flip_count = txb.moveCall({
            target: `${Package}::card_deck::coin_flip_count`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let coin_flip_result = txb.moveCall({
            target: `${Package}::card_deck::coin_flip_result`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let even_turns = txb.moveCall({
            target: `${Package}::card_deck::even_turns`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let odd_turns = txb.moveCall({
            target: `${Package}::card_deck::odd_turns`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let turn_count = txb.moveCall({
            target: `${Package}::card_deck::turn_count`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let confirm_deck_player_one = txb.moveCall({
            target: `${Package}::card_deck::confirm_deck_player_one`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let confirm_deck_player_two = txb.moveCall({
            target: `${Package}::card_deck::confirm_deck_player_two`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let player_one_general_status = txb.moveCall({
            target: `${Package}::card_deck::player_one_general_status`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let player_one_monster_status = txb.moveCall({
            target: `${Package}::card_deck::player_one_monster_status`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let player_one_rider_status = txb.moveCall({
            target: `${Package}::card_deck::player_one_rider_status`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let player_one_soldier_status = txb.moveCall({
            target: `${Package}::card_deck::player_one_soldier_status`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let player_two_general_status = txb.moveCall({
            target: `${Package}::card_deck::player_two_general_status`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let player_two_monster_status = txb.moveCall({
            target: `${Package}::card_deck::player_two_monster_status`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let player_two_rider_status = txb.moveCall({
            target: `${Package}::card_deck::player_two_rider_status`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        let player_two_soldier_status = txb.moveCall({
            target: `${Package}::card_deck::player_two_soldier_status`,
            arguments: [
                txb.object(GAME),  
            ],
        });

        try {
            const gameData = await signAndExecuteTransactionBlock({ transactionBlock: txb });
            console.log('Game Stats!', gameData);
            alert(`Congrats! Game Stats Returned! \n Digest: ${gameData.digest}`);
        } catch (e) {
            console.error('Sorry, Game Stats NOT Returned', e);
        }
    };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Game Stats</h1>
            <h1>Player addresses</h1>
            <p>player_one_address: {player_one_address || "Not set"}</p>
            <p>player_two_address: {player_two_address || "Not set"}</p>

            <h1>Coin Data</h1>
            <p>coin_flip_result: {coin_flip_result || "Not set"}</p>
            <p>coin_flip_guess: {coin_flip_guess || "Not set"}</p>
            <p>coin_flip_count: {coin_flip_count || "Not set"}</p>
            
            <h1>Game Turn Data</h1>
            <p>even_turns: {even_turns || "Not set"}</p>
            <p>odd_turns: {odd_turns || "Not set"}</p>
            <p>turn_count: {turn_count || "Not set"}</p>

            <h1>Game Confirmed Decks Data</h1>
            <p>confirm_deck_player_one: {confirm_deck_player_one || "Not set"}</p>
            <p>confirm_deck_player_two: {confirm_deck_player_two || "Not set"}</p>

            <h1>Player Card Data 1</h1>
            <p>player_one_general_status: {player_one_general_status || "Not set"}</p>
            <p>player_one_monster_status: {player_one_monster_status|| "Not set"}</p>
            <p>player_one_rider_status: {player_one_rider_status || "Not set"}</p>
            <p>player_one_soldier_status: {player_one_soldier_status || "Not set"}</p>

            <h1>Player Card Data 2</h1>
            <p>player_two_general_status: {player_two_general_status || "Not set"}</p>
            <p>player_two_monster_status: {player_two_monster_status || "Not set"}</p>
            <p>player_two_rider_status: {player_two_rider_status || "Not set"}</p>
            <p>player_two_soldier_status: {player_two_soldier_status || "Not set"}</p>

            <button onClick={handleGameStats} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>
                Fetch Game Stats
            </button>
            <button onClick={() => navigate('/')} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>Home</button>
        </div>
    );
};

export default GameStats;

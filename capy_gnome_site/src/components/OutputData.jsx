import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext'; 

const OutputData = () => {
    const navigate = useNavigate();
    const { player1, player2 } = useCardContext(); 
    const gameSetup = JSON.parse(localStorage.getItem('gameSetup')) || { game: "Not set", turnkey: "Not set" };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Player 1 Data</h1>
            <p>Address: {player1.address || "Not set"}</p>
            <p>Confirmed Deck: {player1.confirmDeck || "Not set"}</p>
            <br />
            <p>General ID: {player1.generalId || "Not set"}</p>
            <p>Monster ID: {player1.monsterId || "Not set"}</p>
            <p>Rider ID: {player1.riderId || "Not set"}</p>
            <p>Soldier ID: {player1.soldierId || "Not set"}</p>
            <br />
            <p>General Owner Cap: {player1.generalOwnerCap || "Not set"}</p>
            <p>Monster Owner Cap: {player1.monsterOwnerCap || "Not set"}</p>
            <p>Rider Owner Cap: {player1.riderOwnerCap || "Not set"}</p>
            <p>Soldier Owner Cap: {player1.soldierOwnerCap || "Not set"}</p>
            

            <h1>Player 2 Data</h1>
            <p>Address: {player2.address || "Not set"}</p>
            <p>Confirmed Deck: {player2.confirmDeck || "Not set"}</p>
            <br />
            <p>General ID: {player2.generalId || "Not set"}</p>
            <p>Monster ID: {player2.monsterId || "Not set"}</p>
            <p>Rider ID: {player2.riderId || "Not set"}</p>
            <p>Soldier ID: {player2.soldierId || "Not set"}</p>
            <p>General Owner Cap: {player2.generalOwnerCap || "Not set"}</p>
            <p>Monster Owner Cap: {player2.monsterOwnerCap || "Not set"}</p>
            <p>Rider Owner Cap: {player2.riderOwnerCap || "Not set"}</p>
            <p>Soldier Owner Cap: {player2.soldierOwnerCap || "Not set"}</p>
            

            <h1>Game Setup Data</h1>
            <p>Game: {gameSetup.game}</p>
            <p>Turnkey: {gameSetup.turnkey}</p>

            <button onClick={() => navigate('/')} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>Home</button>
        </div>
    );
};

export default OutputData;

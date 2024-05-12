import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext'; 

const OutputData = () => {
    const navigate = useNavigate();
    const { player1, player2 } = useCardContext(); // Accessing players directly

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Player 1 Data</h1>
            <p>General ID: {player1.generalId || "Not set"}</p>
            <p>Monster ID: {player1.monsterId || "Not set"}</p>
            <p>Rider ID: {player1.riderId || "Not set"}</p>
            <p>Soldier ID: {player1.soldierId || "Not set"}</p>

            <h1>Player 2 Data</h1>
            <p>General ID: {player2.generalId || "Not set"}</p>
            <p>Monster ID: {player2.monsterId || "Not set"}</p>
            <p>Rider ID: {player2.riderId || "Not set"}</p>
            <p>Soldier ID: {player2.soldierId || "Not set"}</p>

            <button onClick={() => navigate('/')} style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', border: 'none', cursor: 'pointer' }}>Home</button>
        </div>
    );
};

export default OutputData;

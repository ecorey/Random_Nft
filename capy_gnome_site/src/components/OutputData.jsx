import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext'; // Import the context hook

const OutputData = () => {
    const navigate = useNavigate();
    const { player1, player2 } = useCardContext(); // Access player data from context

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Player 1 Data</h1>
            <p>General ID: {player1.generalId}</p>
            <p>Monster ID: {player1.monsterId}</p>
            <p>Rider ID: {player1.riderId}</p>
            <p>Soldier ID: {player1.soldierId}</p>

            <h1>Player 2 Data</h1>
            <p>General ID: {player2.generalId}</p>
            <p>Monster ID: {player2.monsterId}</p>
            <p>Rider ID: {player2.riderId}</p>
            <p>Soldier ID: {player2.soldierId}</p>

            <button onClick={() => navigate('/')} style={buttonBackStyle}>Home</button>
        </div>
    );
};

const buttonBackStyle = {
    width: '100%',
    padding: '10px',
    marginTop: '20px',
    backgroundColor: 'blue',
    color: 'white',
    fontSize: '16px',
    border: 'none',
    cursor: 'pointer'
};

export default OutputData;

// src/components/EnterDefenseCards.js
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext'; // Import the context hook

const EnterDefenseCards = () => {
    const navigate = useNavigate();
    const { player, setPlayer, data, handleChange } = useCardContext();

    return (
        <div style={{ padding: '40px', fontFamily: 'pixelify sans', maxWidth: '800px', margin: '40px auto', fontFamily: 'Arial, sans-serif', background: '#f0f0f0', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
            <h2>Configure Defense Cards</h2>
            <select
                value={player}
                onChange={e => setPlayer(e.target.value)}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px' }}
            >
                <option value="Player 1">Player 1</option>
                <option value="Player 2">Player 2</option>
            </select>
            <input
                type="text"
                placeholder="General ID"
                value={data.defenseGeneralId}
                onChange={e => handleChange(e, 'generalId')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px', fontFamily: 'pixelify sans' }}
            />
            <input
                type="text"
                placeholder="Monster ID"
                value={data.defenseMonsterId}
                onChange={e => handleChange(e, 'monsterId')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px', fontFamily: 'pixelify sans' }}
            />
            <input
                type="text"
                placeholder="Rider ID"
                value={data.defenseRiderId}
                onChange={e => handleChange(e, 'riderId')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px', fontFamily: 'pixelify sans' }}
            />
            <input
                type="text"
                placeholder="Soldier ID"
                value={data.defenseSoldierId}
                onChange={e => handleChange(e, 'soldierId')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px', fontFamily: 'pixelify sans' }}
            />
            <button 
                onClick={() => navigate('/')} 
                style={{ width: '100%', padding: '15px', backgroundColor: 'blue', color: 'white', fontSize: '18px', cursor: 'pointer', marginTop: '20px' }}>
                Save Configuration
            </button>
        </div>
    );
};

export default EnterDefenseCards;

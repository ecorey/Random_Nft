import React from 'react';
import { useNavigate } from 'react-router-dom';



const GameConfiguration = () => {
    const navigate = useNavigate();

    const handleConfigureDeck = () => {
        navigate('/configurecards');
    };

    const handleOutputData = () => {
        navigate('/outputdata');
    };




    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', marginTop: '100px' }}>
            <button onClick={handleConfigureDeck} style={{ width: '100%', padding: '10px', backgroundColor: 'blue', color: 'white', fontSize: '16px', cursor: 'pointer' }}>
                Configure Game
            </button>
            <button onClick={handleOutputData} style={{ width: '100%', marginTop: '35px', padding: '10px', backgroundColor: 'blue', color: 'white', fontSize: '16px', cursor: 'pointer' }}>
                Game Configuration
            </button>
            <button onClick={() => navigate('/')} style={buttonBackStyle}>Home</button>
        </div>
    );
};

const buttonBackStyle = {
    width: '100%',
    padding: '10px',
    marginTop: '35px',
    backgroundColor: 'blue',
    color: 'black',
    fontSize: '16px',
    border: 'none',
    cursor: 'pointer'
};

export default GameConfiguration;

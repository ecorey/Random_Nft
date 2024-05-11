import React, { createContext, useContext, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const CardContext = createContext();

const useCardContext = () => useContext(CardContext);

const EnterDefenseCardsWrapper = () => {
  const [player, setPlayer] = useState('Player 1');
  const [player1, setPlayer1] = useState({
    attackerId: '',
    defenseGeneralId: '',
    defenseMonsterId: '',
    defenseRiderId: '',
    defenseSoldierId: '',
    defenseChoice: ''
  });
  const [player2, setPlayer2] = useState({
    attackerId: '',
    defenseGeneralId: '',
    defenseMonsterId: '',
    defenseRiderId: '',
    defenseSoldierId: '',
    defenseChoice: ''
  });

  const handleChange = (e, key) => {
    const { value } = e.target;
    if (player === 'Player 1') {
      setPlayer1(prev => ({ ...prev, [key]: value }));
    } else {
      setPlayer2(prev => ({ ...prev, [key]: value }));
    }
  };

  const value = {
    player, setPlayer,
    data: player === 'Player 1' ? player1 : player2,
    handleChange
  };

  return (
    <CardContext.Provider value={value}>
      <EnterDefenseCards />
    </CardContext.Provider>
  );
};

const EnterDefenseCards = () => {
    const navigate = useNavigate();
    const { player, setPlayer, data, handleChange } = useCardContext();

    return (
        <div style={{ padding: '40px', maxWidth: '800px', margin: '40px auto', fontFamily: 'Arial, sans-serif', background: '#f0f0f0', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
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
                placeholder="Attacker ID"
                value={data.attackerId}
                onChange={e => handleChange(e, 'attackerId')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px' }}
            />
            <input
                type="text"
                placeholder="Defense General ID"
                value={data.defenseGeneralId}
                onChange={e => handleChange(e, 'defenseGeneralId')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px' }}
            />
            <input
                type="text"
                placeholder="Defense Monster ID"
                value={data.defenseMonsterId}
                onChange={e => handleChange(e, 'defenseMonsterId')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px' }}
            />
            <input
                type="text"
                placeholder="Defense Rider ID"
                value={data.defenseRiderId}
                onChange={e => handleChange(e, 'defenseRiderId')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px' }}
            />
            <input
                type="text"
                placeholder="Defense Soldier ID"
                value={data.defenseSoldierId}
                onChange={e => handleChange(e, 'defenseSoldierId')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px' }}
            />
            <input
                type="number"
                placeholder="Defense Choice"
                value={data.defenseChoice}
                onChange={e => handleChange(e, 'defenseChoice')}
                style={{ width: '100%', marginBottom: '20px', padding: '12px', fontSize: '16px' }}
            />
            <button 
                onClick={() => navigate('/')} 
                style={{ width: '100%', padding: '15px', backgroundColor: 'blue', color: 'white', fontSize: '18px', cursor: 'pointer', marginTop: '20px' }}
            >
                Save Configuration
            </button>
        </div>
    );
};

export default EnterDefenseCardsWrapper;

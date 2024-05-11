


// EnterDefenseCards.js
import React, { createContext, useContext, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const CardContext = createContext();

const useCardContext = () => useContext(CardContext);

const EnterDefenseCards = () => {
    const navigate = useNavigate();
    const {
        attackerId, setAttackerId,
        defenseGeneralId, setDefenseGeneralId,
        defenseMonsterId, setDefenseMonsterId,
        defenseRiderId, setDefenseRiderId,
        defenseSoldierId, setDefenseSoldierId,
        defenseChoice, setDefenseChoice
    } = useCardContext();

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto' }}>
            <h2>Configure your defense cards</h2>
                <input
                    type="text"
                    placeholder="Attacker ID"
                    value={attackerId}
                    onChange={e => setAttackerId(e.target.value)}
                    style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
                />
                <input
                    type="text"
                    placeholder="Defense General ID"
                    value={defenseGeneralId}
                    onChange={e => setDefenseGeneralId(e.target.value)}
                    style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
                />
                <input
                    type="text"
                    placeholder="Defense Monster ID"
                    value={defenseMonsterId}
                    onChange={e => setDefenseMonsterId(e.target.value)}
                    style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
                />
                <input
                    type="text"
                    placeholder="Defense Rider ID"
                    value={defenseRiderId}
                    onChange={e => setDefenseRiderId(e.target.value)}
                    style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
                />
                <input
                    type="text"
                    placeholder="Defense Soldier ID"
                    value={defenseSoldierId}
                    onChange={e => setDefenseSoldierId(e.target.value)}
                    style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
                />
                <input
                    type="number"
                    placeholder="Defense Choice"
                    value={defenseChoice}
                    onChange={e => setDefenseChoice(e.target.value)}
                    style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
                />
                <button 
                    onClick={() => navigate('/')} 
                    style={{ width: '100%', padding: '10px', backgroundColor: 'blue', color: 'white', fontSize: '16px', cursor: 'pointer' }}
                >
                    Save Configuration
                </button>
        </div>
    );
};

const EnterDefenseCardsWrapper = () => {
  const [attackerId, setAttackerId] = useState('');
  const [defenseGeneralId, setDefenseGeneralId] = useState('');
  const [defenseMonsterId, setDefenseMonsterId] = useState('');
  const [defenseRiderId, setDefenseRiderId] = useState('');
  const [defenseSoldierId, setDefenseSoldierId] = useState('');
  const [defenseChoice, setDefenseChoice] = useState('');

  const value = {
    attackerId, setAttackerId,
    defenseGeneralId, setDefenseGeneralId,
    defenseMonsterId, setDefenseMonsterId,
    defenseRiderId, setDefenseRiderId,
    defenseSoldierId, setDefenseSoldierId,
    defenseChoice, setDefenseChoice
  };

  return (
    <CardContext.Provider value={value}>
      <EnterDefenseCards />
    </CardContext.Provider>
  );
};

export default EnterDefenseCardsWrapper;





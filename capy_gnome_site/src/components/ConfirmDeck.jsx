import React, { useState } from 'react';

const ConfirmDeck = () => {
  const [generalId, setgeneralId] = useState('');
  const [monsterId, setmonsterId] = useState('');
  const [riderId, setriderId] = useState('');
  const [soldierId, setsoldierId] = useState('');




  const handleConfirm = () => {
   
    
    console.log({ generalId, monsterId, riderId, soldierId });
    alert('Deck Commit Subitted. Check the Chain');

  };




  return (
    <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto' }}>

      <h1 style={{ textAlign: 'center' }}>Confirm Deck</h1>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="generalId" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>General ID</label>
        <input
          type="text"
          id="generalId"
          value={generalId}
          onChange={e => setgeneralId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="monsterId" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Monster ID</label>
        <input
          type="text"
          id="monsterId"
          value={monsterId}
          onChange={e => setmonsterId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="riderId" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Rider ID</label>
        <input
          type="text"
          id="riderId"
          value={riderId}
          onChange={e => setPredictionId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="riderId" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Soldier ID</label>
        <input
          type="text"
          id="riderId"
          value={soldierId}
          onChange={e => setriderId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <button onClick={handleConfirm} style={buttonStyle}>Confirm</button>

    </div>
  );
};

const inputStyle = {
  width: '100%',
  padding: '8px',
  marginBottom: '10px',
  boxSizing: 'border-box'
};

const buttonStyle = {
  width: '100%',
  padding: '10px',
  backgroundColor: 'blue',
  color: 'white',
  fontSize: '16px',
  border: 'none',
  cursor: 'pointer'
};

export default ConfirmDeck;

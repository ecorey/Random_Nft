import React, { useState } from 'react';

const ConfirmDeck = () => {
  const [ownerCapId, setOwnerCapId] = useState('');
  const [kioskId, setKioskId] = useState('');
  const [predictionId, setPredictionId] = useState('');
  const [listPrice, setListPrice] = useState('');

  const handleConfirm = () => {
    // Handle the confirmation logic
    console.log({ ownerCapId, kioskId, predictionId, listPrice });
    alert('Form Submitted! Check console for details.');
  };

  return (
    <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto' }}>
      <h1 style={{ textAlign: 'center' }}>Confirm Deck</h1>
      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="ownerCapId" style={{ display: 'block' }}>Owner Cap ID:</label>
        <input
          type="text"
          id="ownerCapId"
          value={ownerCapId}
          onChange={e => setOwnerCapId(e.target.value)}
          style={inputStyle}
        />
      </div>
      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="kioskId" style={{ display: 'block' }}>Kiosk ID:</label>
        <input
          type="text"
          id="kioskId"
          value={kioskId}
          onChange={e => setKioskId(e.target.value)}
          style={inputStyle}
        />
      </div>
      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="predictionId" style={{ display: 'block' }}>Prediction ID:</label>
        <input
          type="text"
          id="predictionId"
          value={predictionId}
          onChange={e => setPredictionId(e.target.value)}
          style={inputStyle}
        />
      </div>
      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="listPrice" style={{ display: 'block' }}>List Price:</label>
        <input
          type="text"
          id="listPrice"
          value={listPrice}
          onChange={e => setListPrice(e.target.value)}
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

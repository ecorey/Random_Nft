import React, { useState } from 'react';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';

import { useNavigate } from 'react-router-dom';



const ConfirmDeck = () => {
const [generalId, setgeneralId] = useState('');
const [monsterId, setmonsterId] = useState('');
const [riderId, setriderId] = useState('');
const [soldierId, setsoldierId] = useState('');


const navigate = useNavigate();

const handleHomePage = () => {
  navigate('/');  
};


const handleConfirm = () => {
   

  const { signAndExecuteTransactionBlock } = useWallet();



  const txb = new TransactionBlock();


  txb.setGasBudget(1000000000);


  txb.moveCall({
      target: `${Package}::card_deck::confirm_deck`,
      arguments: [txb.object(generalId), txb.object(monsterId), txb.object(riderId), txb.object(soldierId)],
  });

    
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
          onChange={e => setriderId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="soldierId" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Soldier ID</label>
        <input
          type="text"
          id="soldierId"
          value={soldierId}
          onChange={e => setsoldierId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <button onClick={handleConfirm} style={buttonStyle}>Confirm</button>


      <button onClick={handleHomePage} style={buttonBackStyle}>Home</button>



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



const buttonBackStyle = {
  width: '10%',
  padding: '10px',
  marginTop: '75px',
  backgroundColor: 'blue',
  color: 'black',
  fontSize: '16px',
  border: 'none',
  cursor: 'pointer'
};




export default ConfirmDeck;

import React, { useState } from 'react';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';

import { useNavigate } from 'react-router-dom';



const ConfirmDeck = () => {
  
  const { signAndExecuteTransactionBlock } = useWallet();


  const [generalIdGnome, setgeneralIdGnome] = useState('');
  const [monsterIdGnome, setmonsterIdGnome] = useState('');
  const [riderIdGnome, setriderIdGnome] = useState('');
  const [soldierIdGnome, setsoldierIdGnome] = useState('');


  const [generalIdCapy, setgeneralIdCapy] = useState('');
  const [monsterIdCapy, setmonsterIdCapy] = useState('');
  const [riderIdCapy, setriderIdCapy] = useState('');
  const [soldierIdCapy, setsoldierIdCapy] = useState('');


  const navigate = useNavigate();


  const handleHomePage = () => {
    navigate('/');  
  };






const handleConfirmGnomeDeck = () => {

  const txb = new TransactionBlock();
  txb.setGasBudget(1000000000);

  txb.moveCall({
      target: `${Package}::card_deck::confirm_gnome_deck`,
      arguments: [txb.object(generalIdGnome), txb.object(monsterIdGnome), txb.object(riderIdGnome), txb.object(soldierIdGnome)],
  });
    


  try {
        const confirmData = signAndExecuteTransactionBlock({
            transactionBlock: txb
        });
        console.log('Gnome Deck Confirmed!', confirmData);
        alert(`Congrats! Gnome Deck Confirmed! \n Digest: ${confirmData.digest}`);
    } catch (e) {
        console.error('Sorry, Gnome Deck Was Not Confirmed', e);
    }

};






const handleConfirmCapyDeck = () => {

  const txb = new TransactionBlock();
  txb.setGasBudget(1000000000);

  txb.moveCall({
      target: `${Package}::card_deck::confirm_capy_deck`,
      arguments: [txb.object(generalIdCapy), txb.object(monsterIdCapy), txb.object(riderIdCapy), txb.object(soldierIdCapy)],
  });
    


  try {
        const confirmData = signAndExecuteTransactionBlock({
            transactionBlock: txb
        });
        console.log('Capy Deck Confirmed!', confirmData);
        alert(`Congrats! Capy Deck Confirmed! \n Digest: ${confirmData.digest}`);
    } catch (e) {
        console.error('Sorry, Capy Deck Was Not Confirmed', e);
    }

};








  return (
    <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto' }}>

      <h1 style={{ textAlign: 'center' }}>Confirm Gnome Deck</h1>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="generalIdGnome" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Gnome General ID</label>
        <input
          type="text"
          id="generalIdGnome"
          value={generalIdGnome}
          onChange={e => setgeneralIdGnome(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="monsterIdGnome" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Gnome Monster ID</label>
        <input
          type="text"
          id="monsterIdGnome"
          value={monsterIdGnome}
          onChange={e => setmonsterIdGnome(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="riderIdGnome" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Gnome Rider ID</label>
        <input
          type="text"
          id="riderIdGnome"
          value={riderIdGnome}
          onChange={e => setriderIdGnome(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="soldierIdGnome" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Gnome Soldier ID</label>
        <input
          type="text"
          id="soldierIdGnome"
          value={soldierIdGnome}
          onChange={e => setsoldierIdGnome(e.target.value)}
          style={inputStyle}
        />
      </div>

      <button onClick={handleConfirmGnomeDeck} style={buttonStyle}>Confirm Gnome Deck</button>


      <br />
      <br />



      <h1 style={{ textAlign: 'center' }}>Confirm Capy Deck</h1>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="generalIdCapy" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Capy General ID</label>
        <input
          type="text"
          id="generalIdCapy"
          value={generalIdCapy}
          onChange={e => setgeneralIdCapy(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="monsterIdCapy" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Capy Monster ID</label>
        <input
          type="text"
          id="monsterIdCapy"
          value={monsterIdCapy}
          onChange={e => setmonsterIdCapy(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="riderIdCapy" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Capy Rider ID</label>
        <input
          type="text"
          id="riderIdCapy"
          value={riderIdCapy}
          onChange={e => setriderIdCapy(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="soldierIdCapy" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Capy Soldier ID</label>
        <input
          type="text"
          id="soldierIdCapy"
          value={soldierIdCapy}
          onChange={e => setsoldierIdCapy(e.target.value)}
          style={inputStyle}
        />
      </div>

      <button onClick={handleConfirmCapyDeck} style={buttonStyle}>Confirm Gnome Deck</button>







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
  marginBottom: '120px',
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

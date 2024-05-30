import React, { useState, useEffect } from 'react';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext'; // Adjust the path as necessary

const ConfirmDeck = () => {
  const { signAndExecuteTransactionBlock } = useWallet();
  const { player1, player2 } = useCardContext(); // Retrieve context data

  const [selectedPlayer, setSelectedPlayer] = useState('Player 1');
  const [selectedDeck, setSelectedDeck] = useState('Gnome');

  const getInitialData = () => {
    const playerData = selectedPlayer === 'Player 1' ? player1 : player2;
    return selectedDeck === 'Gnome' ? {
      generalId: playerData.generalId,
      generalOwnerCap: playerData.generalOwnerCap,
      monsterId: playerData.monsterId,
      monsterOwnerCap: playerData.monsterOwnerCap,
      riderId: playerData.riderId,
      riderOwnerCap: playerData.riderOwnerCap,
      soldierId: playerData.soldierId,
      soldierOwnerCap: playerData.soldierOwnerCap
    } : {
      generalId: playerData.generalId,
      generalOwnerCap: playerData.generalOwnerCap,
      monsterId: playerData.monsterId,
      monsterOwnerCap: playerData.monsterOwnerCap,
      riderId: playerData.riderId,
      riderOwnerCap: playerData.riderOwnerCap,
      soldierId: playerData.soldierId,
      soldierOwnerCap: playerData.soldierOwnerCap
    };
  };

  const initialData = getInitialData();

  const [generalId, setGeneralId] = useState(initialData.generalId);
  const [generalOwnerCap, setGeneralOwnerCap] = useState(initialData.generalOwnerCap);
  const [monsterId, setMonsterId] = useState(initialData.monsterId);
  const [monsterOwnerCap, setMonsterOwnerCap] = useState(initialData.monsterOwnerCap);
  const [riderId, setRiderId] = useState(initialData.riderId);
  const [riderOwnerCap, setRiderOwnerCap] = useState(initialData.riderOwnerCap);
  const [soldierId, setSoldierId] = useState(initialData.soldierId);
  const [soldierOwnerCap, setSoldierOwnerCap] = useState(initialData.soldierOwnerCap);

  useEffect(() => {
    const data = getInitialData();
    setGeneralId(data.generalId);
    setGeneralOwnerCap(data.generalOwnerCap);
    setMonsterId(data.monsterId);
    setMonsterOwnerCap(data.monsterOwnerCap);
    setRiderId(data.riderId);
    setRiderOwnerCap(data.riderOwnerCap);
    setSoldierId(data.soldierId);
    setSoldierOwnerCap(data.soldierOwnerCap);
  }, [selectedPlayer, selectedDeck, player1, player2]);

  const navigate = useNavigate();

  const handleHomePage = () => {
    navigate('/');
  };

  const handleConfirmDeck = async () => {
    const txb = new TransactionBlock();
    txb.setGasBudget(1000000000);

    const functionName = selectedDeck === 'Gnome' ? 'confirm_gnome_deck' : 'confirm_capy_deck';

    txb.moveCall({
      target: `${Package}::card_deck::${functionName}`,
      arguments: [txb.object(generalId), txb.object(generalOwnerCap), txb.object(monsterId), txb.object(monsterOwnerCap), txb.object(riderId), txb.object(riderOwnerCap), txb.object(soldierId), txb.object(soldierOwnerCap)],
    });

    try {
      const confirmData = await signAndExecuteTransactionBlock({
        transactionBlock: txb
      });
      console.log('Deck Confirmed!', confirmData);
      alert(`Congrats! Deck Confirmed! \n Digest: ${confirmData.digest}`);
    } catch (e) {
      console.error('Sorry, Deck Was Not Confirmed', e);
    }
  };

  return (
    <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto' }}>
      <h1 style={{ textAlign: 'center' }}>Confirm Deck</h1>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="playerSelect" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Select Player</label>
        <select
          id="playerSelect"
          value={selectedPlayer}
          onChange={e => setSelectedPlayer(e.target.value)}
          style={inputStyle}
        >
          <option value="Player 1">Player 1</option>
          <option value="Player 2">Player 2</option>
        </select>
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="deckSelect" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Select Deck</label>
        <select
          id="deckSelect"
          value={selectedDeck}
          onChange={e => setSelectedDeck(e.target.value)}
          style={inputStyle}
        >
          <option value="Gnome">Gnome</option>
          <option value="Capy">Capy</option>
        </select>
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="generalId" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>General ID</label>
        <input
          type="text"
          id="generalId"
          value={generalId}
          onChange={e => setGeneralId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="generalOwnerCap" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>General Owner Cap</label>
        <input
          type="text"
          id="generalOwnerCap"
          value={generalOwnerCap}
          onChange={e => setGeneralOwnerCap(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="monsterId" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Monster ID</label>
        <input
          type="text"
          id="monsterId"
          value={monsterId}
          onChange={e => setMonsterId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="monsterOwnerCap" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Monster Owner Cap</label>
        <input
          type="text"
          id="monsterOwnerCap"
          value={monsterOwnerCap}
          onChange={e => setMonsterOwnerCap(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="riderId" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Rider ID</label>
        <input
          type="text"
          id="riderId"
          value={riderId}
          onChange={e => setRiderId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="riderOwnerCap" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Rider Owner Cap</label>
        <input
          type="text"
          id="riderOwnerCap"
          value={riderOwnerCap}
          onChange={e => setRiderOwnerCap(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="soldierId" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Soldier ID</label>
        <input
          type="text"
          id="soldierId"
          value={soldierId}
          onChange={e => setSoldierId(e.target.value)}
          style={inputStyle}
        />
      </div>

      <div style={{ marginBottom: '10px' }}>
        <label htmlFor="soldierOwnerCap" style={{ display: 'block', fontFamily: 'pixelify sans', color: 'white' }}>Soldier Owner Cap</label>
        <input
          type="text"
          id="soldierOwnerCap"
          value={soldierOwnerCap}
          onChange={e => setSoldierOwnerCap(e.target.value)}
          style={inputStyle}
        />
      </div>

      <button onClick={handleConfirmDeck} style={buttonStyle}>Confirm Deck</button>

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
  marginBottom: '120px',
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

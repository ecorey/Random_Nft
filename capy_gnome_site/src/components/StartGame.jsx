import React, { useState } from 'react';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';
import { useNavigate } from 'react-router-dom';

const StartGame = () => {
    const { signAndExecuteTransactionBlock } = useWallet();
    const [gameId, setGameId] = useState('');
    const navigate = useNavigate();

    const handleStartGame = async () => {
        const txb = new TransactionBlock();
        txb.setGasBudget(1000000000);
        txb.moveCall({
            target: `${Package}::card_deck::start_game`,
            arguments: [txb.object(gameId)],
        });

        try {
            const gameData = await signAndExecuteTransactionBlock({
                transactionBlock: txb
            });
            console.log('Game Started!', gameData);
            alert(`Congrats! Game Started! \n Digest: ${gameData.digest}`);
        } catch (e) {
            console.error('Sorry, Game NOT Started', e);
        }
    };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto' }}>
            <input
                type="text"
                placeholder="Enter Game ID"
                value={gameId}
                onChange={(e) => setGameId(e.target.value)}
                style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
            />
            <button onClick={handleStartGame} style={{ width: '100%', padding: '10px', backgroundColor: 'blue', color: 'white', fontSize: '16px', cursor: 'pointer' }}>
                Start Game
            </button>
            <button onClick={() => navigate('/')} style={buttonBackStyle}>Home</button>
        </div>
    );
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

export default StartGame;

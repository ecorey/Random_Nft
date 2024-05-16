import React, { useState } from 'react';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package, RANDOM } from '../../../scripts/config';
import { useNavigate } from 'react-router-dom';

const StartGame = () => {
    const { signAndExecuteTransactionBlock } = useWallet();
    const [guess, setGuess] = useState('');
    const [playerOneAddress, setPlayerOneAddress] = useState('');
    const [playerTwoAddress, setPlayerTwoAddress] = useState('');
    const [confirmDeckPlayerOne, setConfirmDeckPlayerOne] = useState('');
    const [confirmDeckPlayerTwo, setConfirmDeckPlayerTwo] = useState('');
    const navigate = useNavigate();

    const handleStartGame = async () => {
        const txb = new TransactionBlock();
        txb.setGasBudget(1000000000);
        txb.moveCall({
            target: `${Package}::card_deck::start_game`,
            arguments: [
                txb.pure.u8(guess),
                txb.object(RANDOM),  
                txb.pure.address(playerOneAddress),
                txb.pure.address(playerTwoAddress),
                txb.object(confirmDeckPlayerOne),
                txb.object(confirmDeckPlayerTwo),
            ],
        });

        try {
            const gameData = await signAndExecuteTransactionBlock({ transactionBlock: txb });
            console.log('Game Started!', gameData);
            alert(`Congrats! Game Started! \n Digest: ${gameData.digest}`);
        } catch (e) {
            console.error('Sorry, Game NOT Started', e);
        }
    };

    

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', marginTop: '100px' }}>
            <input
                type="text"
                placeholder="Enter Coin Flip Guess"
                value={guess}
                onChange={(e) => setGuess(e.target.value)}
                style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
            />
            <input
                type="text"
                placeholder="First Player Address"
                value={playerOneAddress}
                onChange={(e) => setPlayerOneAddress(e.target.value)}
                style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
            />
            <input
                type="text"
                placeholder="Second Player Address"
                value={playerTwoAddress}
                onChange={(e) => setPlayerTwoAddress(e.target.value)}
                style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
            />
            <input
                type="text"
                placeholder="First Player Deck Confirmation ID"
                value={confirmDeckPlayerOne}
                onChange={(e) => setConfirmDeckPlayerOne(e.target.value)}
                style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
            />
            <input
                type="text"
                placeholder="Second Player Deck Confirmation ID"
                value={confirmDeckPlayerTwo}
                onChange={(e) => setConfirmDeckPlayerTwo(e.target.value)}
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
    width: '100%',
    padding: '10px',
    marginTop: '175px',
    backgroundColor: 'blue',
    color: 'black',
    fontSize: '16px',
    border: 'none',
    cursor: 'pointer'
};

export default StartGame;

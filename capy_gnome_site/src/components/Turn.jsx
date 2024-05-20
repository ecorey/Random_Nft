import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext'; 
import { useWallet } from '@suiet/wallet-kit';  
import { Package, RANDOM } from '../../../scripts/config';



// UNDER CONSTRUCTION


const Turn = () => {

    const [message, setMessage] = useState('');
    const fullText = "Would you like to ATTACK or PASS.";
    const [cardMessage, setCardMessage] = useState('');
    const cardFullText = "What card would you like to attack with?";
    const [actionValue, setActionValue] = useState(null);
    const [cardType, setCardType] = useState('');
    const [defenseChoice, setDefenseChoice] = useState('');
    const [isFinal, setIsFinal] = useState(false);
    const { player, setPlayer, player1, player2, handleChange } = useCardContext();  
    const navigate = useNavigate();
    const { signAndExecuteTransactionBlock } = useWallet(); 


    const gameSetup = JSON.parse(localStorage.getItem('gameSetup')) || { game: "Not set", turnkey: "Not set" };
    const GAME = gameSetup.game;
    const TurnKey = gameSetup.turnkey;

    

    const data = player === 'Player 1' ? player1 : player === 'Player 2' ? player2 : gameData;



    const AttackCard = "";



    useEffect(() => {

        if (message.length < fullText.length) {
            const timer = setTimeout(() => {
                setMessage(currentMessage => currentMessage + fullText.charAt(message.length));
            }, 100);
            return () => clearTimeout(timer);
        }
    }, [message, fullText]);

    useEffect(() => {
        if (actionValue === 55 && cardMessage.length < cardFullText.length) {
            const timer = setTimeout(() => {
                setCardMessage(currentMessage => currentMessage + cardFullText.charAt(cardMessage.length));
            }, 100);
            return () => clearTimeout(timer);
        }
    }, [cardMessage, cardFullText, actionValue]);

    const handleNewChange = (e) => {
        if (!isFinal) {
            setActionValue(Number(e.target.value));
        }
    };

    const handleCardTypeChange = (e) => {
        if (!isFinal) {
            setCardType(e.target.value);
        }
    };

    const handleDefenseChoiceChange = (e) => {
        setDefenseChoice(Number(e.target.value));
    };



    const handleTurn= async () => {


        const txb = new TransactionBlock();

        txb.setGasBudget(1000000000);


        // r: &Random, turn_key: TurnKey, game: &mut Game, attacker: Card, attacker_deck_confirmed: &ConfirmedDeck, defense_choice: u8, defender_deck_confirmed: &ConfirmedDeck,  possible_defense_general: Card, possible_defense_monster: Card, possible_defense_rider: Card, possible_defense_soldier: Card, ctx: &mut TxContext){

        txb.moveCall({
            target: `${Package}::card_deck::turn_trial`,
            arguments: [
                txb.pure.u8(guess),
                txb.object(RANDOM),
                txb.object(TurnKey),  
                txb.object(GAME),
                txb.object(AttackCard),
                txb.object(confirmDeckPlayerOne),
                txb.pure.u8(defenseChoice),
                txb.object(confirmDeckPlayerTwo),
                txb.pure.address(playerOneAddress),
                txb.pure.address(playerTwoAddress),
                txb.object(possible_defense_general),
                txb.object(possible_defense_monster),
                txb.object(possible_defense_rider),
                txb.object(possible_defense_soldier),
                
                
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



    
    
    const executeTurn = async () => {
        setIsFinal(true);
        try {
            const txb = {}; 
            const result = await signAndExecuteTransactionBlock(txb);
            console.log('Transaction result:', result);
        } catch (error) {
            console.error('Error executing turn:', error);
        }
    };


    useEffect(() => {
        if (isFinal) {
            executeTurn();
        }
    }, [isFinal]);

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center', fontFamily: 'Pixelify sans, sans-serif', whiteSpace: 'pre-wrap', overflowX: 'auto' }}>
            <select
                onChange={(e) => setCurrentPlayer(e.target.value)}
                style={{ padding: '10px', marginBottom: '20px', fontFamily: 'Pixelify sans', fontSize: '16px' }}
            >
                <option value="player1">Player 1</option>
                <option value="player2">Player 2</option>
            </select>
            <div style={scrollTextStyle}>
                {message}
            </div>
            {message.length === fullText.length && !isFinal && (
                <select style={selectStyle} onChange={handleNewChange}>
                    <option value="">Select Action</option>
                    <option value="55">ATTACK</option>
                    <option value="77">PASS</option>
                </select>
            )}
            {actionValue === 55 && cardMessage && !isFinal && (
                <div style={{ marginTop: '20px' }}>
                    <p style={scrollTextStyle}>{cardMessage}</p>
                    <select style={selectStyle} onChange={handleCardTypeChange}>
                        <option value="">Select Card</option>
                        <option value="general">General</option>
                        <option value="monster">Monster</option>
                        <option value="rider">Rider</option>
                        <option value="soldier">Soldier</option>
                    </select>
                    <select style={selectStyle} onChange={handleDefenseChoiceChange}>
                        <option value="">Select Defense</option>
                        <option value="1">Defense 1</option>
                        <option value="2">Defense 2</option>
                    </select>
                </div>
            )}
            {isFinal && <p style={scrollTextStyle}>Selected Action: {actionValue === 55 ? 'ATTACK' : 'PASS'}{cardType && ` with ${cardType}`}, Defense: {defenseChoice}</p>}
        </div>
    );
};

const scrollTextStyle = {
    backgroundColor: '#232323',
    color: 'white',
    fontFamily: 'Pixelify sans',
    padding: '10px',
    fontSize: '22px',
    overflow: 'hidden',
    minHeight: '50px',
    margin: '10px 0'
};

const selectStyle = {
    marginTop: '10px',
    padding: '10px',
    fontFamily: 'Pixelify sans',
    fontSize: '16px',
};

export default Turn;

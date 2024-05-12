import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useCardContext } from './CardContext';  // Import the context hook

const Turn = () => {
    const [message, setMessage] = useState('');
    const fullText = "Would you like to ATTACK or PASS.";
    const [cardMessage, setCardMessage] = useState('');
    const cardFullText = "What card would you like to attack with?";
    const [actionValue, setActionValue] = useState(null); 
    const [cardType, setCardType] = useState('');  
    const [isFinal, setIsFinal] = useState(false);  
    const [currentPlayer, setCurrentPlayer] = useState('player1'); //  to select player
    const { player1, player2 } = useCardContext();  //  context to get player data
    const playerData = currentPlayer === 'player1' ? player1 : player2;
    const navigate = useNavigate();

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

    const handleChange = (e) => {
        if (!isFinal) {  
            console.log(`Answer selected: ${e.target.value}`);
            if (e.target.value === 'yes') {
                setActionValue(55);  // ATTACK
            } else if (e.target.value === 'no') {
                setActionValue(77);  // PASS
                setIsFinal(true);  // make choice final if PASS is selected
            }
        }
    };

    const handleCardTypeChange = (e) => {
        if (!isFinal) { 
            setCardType(e.target.value);
            setIsFinal(true);  
            console.log(`Card selected: ${e.target.value}`);
        }
    };

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
                <select style={selectStyle} onChange={handleChange} value={actionValue === 55 ? 'yes' : actionValue === 77 ? 'no' : ''}>
                    <option value="">Select Action</option>
                    <option value="yes">ATTACK</option>
                    <option value="no">PASS</option>
                </select>
            )}
            {actionValue === 55 && cardMessage && (
                <div style={{ marginTop: '20px' }}>
                    <p style={scrollTextStyle}>{cardMessage}</p> 
                    {!isFinal && (
                        <select style={selectStyle} onChange={handleCardTypeChange}>
                            <option value="">Select Card</option>
                            <option value="general">General</option>
                            <option value="monster">Monster</option>
                            <option value="rider">Rider</option>
                            <option value="soldier">Soldier</option>
                        </select>
                    )}
                </div>
            )}
            {isFinal && <p style={scrollTextStyle}>Selected Action: {actionValue === 55 ? 'ATTACK' : 'PASS'}{cardType && ` with ${cardType}`}</p>}
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

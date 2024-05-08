import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

const Turn = () => {
    const [message, setMessage] = useState('');
    const fullText = "Would you like to ATTACK or PASS.";
    const [cardMessage, setCardMessage] = useState('');
    const cardFullText = "What card would you like to attack with?";
    const [actionValue, setActionValue] = useState(null);  // State to hold the numerical value for attack or pass
    const [cardType, setCardType] = useState('');  // State to hold the selected card type
    const [isFinal, setIsFinal] = useState(false);  // State to make choice final
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
        if (!isFinal) {  // Only allow change if final choice isn't made
            console.log(`Answer selected: ${e.target.value}`);
            if (e.target.value === 'yes') {
                setActionValue(55);  // ATTACK
            } else if (e.target.value === 'no') {
                setActionValue(77);  // PASS
                setIsFinal(true);  // Make choice final if PASS is selected
            }
        }
    };

    const handleCardTypeChange = (e) => {
        if (!isFinal) {  // Only allow change if final choice isn't made
            setCardType(e.target.value);
            setIsFinal(true);  // Make choice final after a card is selected
            console.log(`Card selected: ${e.target.value}`);
        }
    };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center', fontFamily: 'pixelify sans', whiteSpace: 'pre-wrap', overflowX: 'auto' }}>
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
                    <p style={{ ...scrollTextStyle, fontSize: '16px' }}>{cardMessage}</p>
                    {!isFinal && (
                        <select style={selectStyle} onChange={handleCardTypeChange}>
                            <option value="">Select Card</option>
                            <option value="general">General</option>
                            <option value="monster">Monster</option>
                            <option value="rider">Rider</option>
                            <option value="capy">Capy</option>
                        </select>
                    )}
                </div>
            )}
            {isFinal && <p>Selected Action: {actionValue === 55 ? 'ATTACK' : 'PASS'}{cardType && ` with ${cardType}`}</p>}
        </div>
    );
};

const scrollTextStyle = {
    backgroundColor: '#232323',
    color: 'white',
    fontFamily: 'pixelify sans',
    padding: '10px',
    fontSize: '22px',
    overflow: 'hidden',
    minHeight: '50px',
};

const selectStyle = {
    marginTop: '10px',
    padding: '10px',
    fontFamily: 'pixelify sans',
    fontSize: '16px',
};

export default Turn;

import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

const Turn = () => {
    const [message, setMessage] = useState('');
    const fullText = "Would you like to ATTACK or PASS.";
    const navigate = useNavigate();

    useEffect(() => {
        if (message.length < fullText.length) {
            const timer = setTimeout(() => {
                // Use functional update for message to directly access and update the latest state
                setMessage(currentMessage => currentMessage + fullText.charAt(message.length));
            }, 100); // Adjust speed of typing
            return () => clearTimeout(timer); // Cleanup the timeout to avoid memory leaks
        }
    }, [message, fullText]); // Depend on message length to trigger updates

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center', fontFamily: 'pixelify sans', whiteSpace: 'pre-wrap', overflowX: 'auto' }}>
            <div style={scrollTextStyle}>
                {message}
            </div>
            {message.length === fullText.length && (
                <select style={selectStyle} onChange={(e) => console.log(`Answer selected: ${e.target.value}`)}>
                    <option value="yes">ATTACK</option>
                    <option value="no">PASS</option>
                </select>
            )}
        </div>
    );
};

const scrollTextStyle = {
    backgroundColor: '#232323',
    color: 'black',
    fontFamily: 'pixelify sans',
    padding: '10px',
    fontSize: '22px',
    overflow: 'hidden', // Ensures the text box only shows the current text
    minHeight: '50px',
};

const selectStyle = {
    marginTop: '10px',
    padding: '10px',
    fontFamily: 'pixelify sans',
    fontSize: '16px',
};

export default Turn;

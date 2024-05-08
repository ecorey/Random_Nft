import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

const Turn = () => {
    const [message, setMessage] = useState('');
    const fullText = "Would you like to ATTACK or PASS.";
    const [actionValue, setActionValue] = useState(null);  // State to hold the numerical value
    const navigate = useNavigate();

    useEffect(() => {
        if (message.length < fullText.length) {
            const timer = setTimeout(() => {
                setMessage(currentMessage => currentMessage + fullText.charAt(message.length));
            }, 100); // Controls the speed of typing
            return () => clearTimeout(timer); // Cleanup the timeout
        }
    }, [message, fullText]);

    const handleChange = (e) => {
        console.log(`Answer selected: ${e.target.value}`);
        // Update actionValue based on selection
        if (e.target.value === 'yes') {
            setActionValue(55);  // ATTACK
        } else if (e.target.value === 'no') {
            setActionValue(77);  // PASS
        }
    };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center', fontFamily: 'pixelify sans', whiteSpace: 'pre-wrap', overflowX: 'auto' }}>
            <div style={scrollTextStyle}>
                {message}
            </div>
            {message.length === fullText.length && (
                <select style={selectStyle} onChange={handleChange}>
                    <option value="yes">ATTACK</option>
                    <option value="no">PASS</option>
                </select>
            )}
            {actionValue && <p>Selected Action Value: {actionValue}</p>} {/* Displaying the action value for demonstration */}
        </div>
    );
};

const scrollTextStyle = {
    backgroundColor: '#232323',
    color: 'black',
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

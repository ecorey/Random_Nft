import React, { createContext, useContext, useState } from 'react';

export const CardContext = createContext();

export const useCardContext = () => useContext(CardContext);

export const CardProvider = ({ children }) => {
    const [player, setPlayer] = useState('Player 1');
    const [player1, setPlayer1] = useState({
        generalId: '',
        monsterId: '',
        riderId: '',
        soldierId: ''
    });
    const [player2, setPlayer2] = useState({
        generalId: '',
        monsterId: '',
        riderId: '',
        soldierId: ''
    });

    const handleChange = (e, key) => {
        const { value } = e.target;
        if (player === 'Player 1') {
            setPlayer1(prev => ({ ...prev, [key]: value }));
        } else {
            setPlayer2(prev => ({ ...prev, [key]: value }));
        }
    };

    const value = {
        player, 
        setPlayer,
        data: player === 'Player 1' ? player1 : player2,
        handleChange
    };

    return (
        <CardContext.Provider value={value}>
            {children}
        </CardContext.Provider>
    );
};

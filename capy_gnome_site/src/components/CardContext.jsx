import React, { createContext, useContext, useState, useEffect } from 'react';

export const CardContext = createContext();

export const useCardContext = () => useContext(CardContext);

const getInitialState = (key, defaultValue) => {
    const storedItem = localStorage.getItem(key);
    if (storedItem) {
        return JSON.parse(storedItem);
    }
    return defaultValue;
};

export const CardProvider = ({ children }) => {
    const [player, setPlayer] = useState(getInitialState('player', 'Player 1'));
    const [player1, setPlayer1] = useState(getInitialState('player1', {
        generalId: '',
        monsterId: '',
        riderId: '',
        soldierId: '',
        generalOwnerCap: '',
        monsterOwnerCap: '',
        riderOwnerCap: '',
        soldierOwnerCap: '',
        address: '',
        confirmDeck: ''
    }));
    const [player2, setPlayer2] = useState(getInitialState('player2', {
        generalId: '',
        monsterId: '',
        riderId: '',
        soldierId: '',
        generalOwnerCap: '',
        monsterOwnerCap: '',
        riderOwnerCap: '',
        soldierOwnerCap: '',
        address: '',
        confirmDeck: ''
    }));

    // effect to update localStorage when player1 or player2 data changes
    useEffect(() => {
        localStorage.setItem('player', JSON.stringify(player));
        localStorage.setItem('player1', JSON.stringify(player1));
        localStorage.setItem('player2', JSON.stringify(player2));
    }, [player, player1, player2]);

    const handleChange = (e, key) => {
        const { value } = e.target;
        if (player === 'Player 1') {
            setPlayer1(prev => {
                const updated = { ...prev, [key]: value };
                localStorage.setItem('player1', JSON.stringify(updated));
                return updated;
            });
        } else {
            setPlayer2(prev => {
                const updated = { ...prev, [key]: value };
                localStorage.setItem('player2', JSON.stringify(updated));
                return updated;
            });
        }
    };

    const value = {
        player, 
        setPlayer,
        player1,
        player2,
        handleChange
    };

    return (
        <CardContext.Provider value={value}>
            {children}
        </CardContext.Provider>
    );
};

import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package, RANDOM } from '../../../scripts/config';

const Turn = () => {
    const navigate = useNavigate();
    const { signAndExecuteTransactionBlock } = useWallet(); 
    const [message, setMessage] = useState('');
    const fullText = "Would you like to ATTACK or PASS.";
    const [cardMessage, setCardMessage] = useState('');
    const cardFullText = "What card would you like to attack with?";
    const [actionValue, setActionValue] = useState(null);
    const [capyOrGnome, setCapyOrGnome] = useState('Gnome'); 
    const [cardType, setCardType] = useState('');
    const [defenseChoice, setDefenseChoice] = useState('');
    const [isFinal, setIsFinal] = useState(false);
    const [currentPlayer, setCurrentPlayer] = useState('Player 1');

    // Read game and turn key from local storage
    const gameSetup = JSON.parse(localStorage.getItem('gameSetup')) || { game: "Not set", turnkey: "Not set" };
    const GAME = gameSetup.game;
    const TurnKey = gameSetup.turnkey;

    // Read player data from local storage
    const storedPlayer1 = JSON.parse(localStorage.getItem('player1')) || {};
    const storedPlayer2 = JSON.parse(localStorage.getItem('player2')) || {};

    // Define player addresses and confirm decks
    const playerOneAddress = storedPlayer1.address;
    const playerTwoAddress = storedPlayer2.address;
    const confirmDeckPlayerOne = storedPlayer1.confirmDeck;
    const confirmDeckPlayerTwo = storedPlayer2.confirmDeck;

    // Get player cards based on currentPlayer
    const playerCards = currentPlayer === 'Player 1' ? storedPlayer1 : storedPlayer2;
    const opponentCards = currentPlayer === 'Player 1' ? storedPlayer2 : storedPlayer1;

    // Get card ids for attacker
    const possible_attack_general = playerCards.generalId;
    const possible_attack_monster = playerCards.monsterId;
    const possible_attack_rider = playerCards.riderId;
    const possible_attack_soldier = playerCards.soldierId;

    // Get card owner caps
    const possible_attack_general_owner_cap = playerCards.generalOwnerCap;
    const possible_attack_monster_owner_cap = playerCards.monsterOwnerCap;
    const possible_attack_rider_owner_cap = playerCards.riderOwnerCap;
    const possible_attack_soldier_owner_cap = playerCards.soldierOwnerCap;

    // Get card ids for defender
    const possible_defense_general = opponentCards.generalId;
    const possible_defense_monster = opponentCards.monsterId;
    const possible_defense_rider = opponentCards.riderId;
    const possible_defense_soldier = opponentCards.soldierId;

    // Get the chosen attack card
    const [attackCard, setAttackCard] = useState('');
    const [attackOwnerCap, setAttackOwnerCap] = useState('');

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

    const handleAttackOrPassChange = async (e) => {
        const selectedAction = Number(e.target.value);
        if (!isFinal) {
            setActionValue(selectedAction);

            if (selectedAction === 77) { // If PASS is selected
                const txb = new TransactionBlock();
                txb.setGasBudget(1000000000);
                txb.moveCall({
                    target: `${Package}::card_deck::pass_turn_key_on_pass`,
                    arguments: [txb.object(TurnKey), txb.object(GAME)],
                });

                try {
                    const gameData = await signAndExecuteTransactionBlock({ transactionBlock: txb });
                    console.log('Turn Key Passed and CP ADDED!', gameData);
                    alert(`Turn Key Passed and CP ADDED! \n Digest: ${gameData.digest}`);
                } catch (e) {
                    console.error('Sorry, Turn Key Not Passed', e);
                }
            }
        }
    };

    const handleCardTypeChange = (e) => {
        if (!isFinal) {
            const selectedCardType = e.target.value;
            setCardType(selectedCardType);

            if (selectedCardType === 'general') {
                setAttackCard(possible_attack_general);
                setAttackOwnerCap(possible_attack_general_owner_cap);
            } else if (selectedCardType === 'monster') {
                setAttackCard(possible_attack_monster);
                setAttackOwnerCap(possible_attack_monster_owner_cap);
            } else if (selectedCardType === 'rider') {
                setAttackCard(possible_attack_rider);
                setAttackOwnerCap(possible_attack_rider_owner_cap);
            } else if (selectedCardType === 'soldier') {
                setAttackCard(possible_attack_soldier);
                setAttackOwnerCap(possible_attack_soldier_owner_cap);
            }
        }
    };

    const handleDefenseChoiceChange = (e) => {
        setDefenseChoice(Number(e.target.value));
    };

    const handleTurn = async () => {
        const txb = new TransactionBlock();
        txb.setGasBudget(1000000000);

        let attackerConfirmDeck;
        let defenderConfirmDeck;
        let attackerAddress;
        let defenderAddress;

        if (currentPlayer === 'Player 1') {
            attackerConfirmDeck = confirmDeckPlayerOne;
            defenderConfirmDeck = confirmDeckPlayerTwo;
            attackerAddress = playerOneAddress;
            defenderAddress = playerTwoAddress;
        } else {
            attackerConfirmDeck = confirmDeckPlayerTwo;
            defenderConfirmDeck = confirmDeckPlayerOne;
            attackerAddress = playerTwoAddress;
            defenderAddress = playerOneAddress;
        }

        console.log(`Attacker Address: ${attackerAddress}, Defender Address: ${defenderAddress}`);
        console.log(`Attacker Confirm Deck: ${attackerConfirmDeck}, Defender Confirm Deck: ${defenderConfirmDeck}`);
        console.log(`Attack Card: ${attackCard}, Defense Choice: ${defenseChoice}`);

        console.log("DEFENSE CHOICE TYPE:");
        console.log(typeof defenseChoice);
        
        console.log("RANDOM:");
        console.log(RANDOM);
        
        console.log("TurnKey:");
        console.log(TurnKey);
        
        console.log("GAME:");
        console.log(GAME);

        console.log("attackCard:");
        console.log(attackCard);

        console.log("attackOwnerCap:");
        console.log(attackOwnerCap);

        console.log("possible_defense_general:");
        console.log(possible_defense_general);

        console.log("possible_defense_monster:");
        console.log(possible_defense_monster);

        console.log("possible_defense_rider:");
        console.log( possible_defense_rider);

        console.log("possible_defense_soldier:");
        console.log( possible_defense_soldier);



        let functionName = '';
        if (capyOrGnome === 'Gnome') {
            functionName = `turn_gnome_${cardType}`;
        } else if (capyOrGnome === 'Capy') {
            functionName = `turn_capy_${cardType}`;
        }

        txb.moveCall({
            target: `${Package}::card_deck::${functionName}`,
            arguments: [
                txb.object(RANDOM),
                txb.object(TurnKey),  
                txb.object(GAME),
                txb.object(attackCard),
                txb.object(attackOwnerCap),
                txb.pure.u8(defenseChoice),
                txb.object(possible_defense_general),
                txb.object(possible_defense_monster),
                txb.object(possible_defense_rider),
                txb.object(possible_defense_soldier),
            ],
        });

        try {
            const gameData = await signAndExecuteTransactionBlock({ transactionBlock: txb });
            console.log('Battle Complete!', gameData);
            alert(`Battle Complete! \n Digest: ${gameData.digest}`);
        } catch (e) {
            console.error('Sorry, Battle Error', e);
        }
    };

    useEffect(() => {
        if (isFinal) {
            handleTurn();
        }
    }, [isFinal]);

    const handleButtonClick = () => {
        setIsFinal(true);
    };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center', fontFamily: 'Pixelify sans, sans-serif', whiteSpace: 'pre-wrap', overflowX: 'auto' }}>
            <select
                onChange={(e) => setCurrentPlayer(e.target.value)}
                style={{ padding: '10px', marginBottom: '20px', fontFamily: 'Pixelify sans', fontSize: '16px' }}
            >
                <option value="Player 1">Player 1</option>
                <option value="Player 2">Player 2</option>
            </select>
            <select
                onChange={(e) => setCapyOrGnome(e.target.value)}
                style={{ padding: '10px', marginBottom: '20px', fontFamily: 'Pixelify sans', fontSize: '16px' }}
            >
                <option value="Gnome">Gnome</option>
                <option value="Capy">Capy</option>
            </select>
            <div style={scrollTextStyle}>
                {message}
            </div>
            {message.length === fullText.length && !isFinal && (
                <select style={selectStyle} onChange={handleAttackOrPassChange}>
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
                        <option value="1">Backline Defense Stance</option>
                        <option value="2">Frontline Defense Stance</option>
                    </select>
                </div>
            )}
            {actionValue === 55 && cardType && defenseChoice && !isFinal && (
                <button 
                    onClick={handleButtonClick}
                    style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', cursor: 'pointer' }}
                >
                    Perform Battle Action
                </button>
            )}
            {isFinal && (
                <>
                    <p style={scrollTextStyle}>
                        Selected Action: {actionValue === 55 ? 'ATTACK' : 'PASS'}
                        {cardType && ` with ${cardType}`}, Defense: {defenseChoice}
                    </p>
                    <button 
                        onClick={() => navigate('/')}
                        style={{ width: '100%', padding: '10px', marginTop: '20px', backgroundColor: 'blue', color: 'white', fontSize: '16px', cursor: 'pointer' }}
                    >
                        Home
                    </button>
                </>
            )}
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

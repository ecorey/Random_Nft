import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';

const ClaimWinnings = () => {

    const { signAndExecuteTransactionBlock } = useWallet();
    const [trophyOwnerCap, setTrophyOwnerCap] = useState('');
    const [recipient, setRecipient] = useState('');
    const navigate = useNavigate();

    const handleClaimWinnings = async () => {
        
        const txb = new TransactionBlock();
        txb.setGasBudget(1000000000);
        txb.moveCall({
            target: `${Package}::card_deck::claim_winnings_and_send_trophy_cap_to_treasurer`,
            arguments: [
                txb.object(trophyOwnerCap),
                txb.pure.address(recipient),
            ],
        });

        try {
            const result = await signAndExecuteTransactionBlock({ transactionBlock: txb });
            console.log('Winnings Claimed!', result);
            alert(`Winnings Claimed! \n Digest: ${result.digest}`);
        } catch (e) {
            console.error('Sorry, Winnings NOT Claimed', e);
        }
    };

    return (
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', marginTop: '100px', fontFamily: 'pixelify sans' }}>
            <input
                type="text"
                placeholder="Enter Trophy Owner Cap"
                value={trophyOwnerCap}
                onChange={(e) => setTrophyOwnerCap(e.target.value)}
                style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
            />
            <p>Enter PLECO Treasurer's Address (0xb7b54b78232c1f91ee518054888324dbed7db7f8143001146f68a52e28d66cce) </p>
            <input
                type="text"
                placeholder="Enter PLECO Treasurer's Address"
                value={recipient}
                onChange={(e) => setRecipient(e.target.value)}
                style={{ width: '100%', marginBottom: '10px', padding: '8px' }}
            />
            <button onClick={handleClaimWinnings} style={buttonStyle}>
                Claim Winnings
            </button>
            <button onClick={() => navigate('/')} style={buttonBackStyle}>Home</button>
        </div>
    );
};

const buttonStyle = {
    width: '100%',
    padding: '10px',
    backgroundColor: 'blue',
    color: 'white',
    fontSize: '16px',
    cursor: 'pointer',
    border: 'none',
    marginTop: '10px'
};

const buttonBackStyle = {
    width: '100%',
    padding: '10px',
    marginTop: '10px',
    backgroundColor: 'blue',
    color: 'black',
    fontSize: '16px',
    border: 'none',
    cursor: 'pointer'
};

export default ClaimWinnings;

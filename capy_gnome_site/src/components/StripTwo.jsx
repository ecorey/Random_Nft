import React from 'react';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';

import { useNavigate } from 'react-router-dom';


const StripTwo = () => {

    const { signAndExecuteTransactionBlock } = useWallet();
    
    const navigate = useNavigate(); // Initialize navigate function


 

    const handleLore = () => {
        navigate('/lore');  
    };

   


    return (
        <div>
        
        <button style={buttonStyle} onClick={handleLore}>LORE</button>

            
        </div>
    );
};



const buttonStyle = {
    background: 'none',
    color: 'white',
    border: 'none',
    padding: '10px',
    fontSize: '20px',
    cursor: 'pointer',
    outline: 'none'
};



export default StripTwo;



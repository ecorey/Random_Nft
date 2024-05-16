import React from 'react';
import { useWallet } from '@suiet/wallet-kit';
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { Package } from '../../../scripts/config';

import { useNavigate } from 'react-router-dom';


const StripThree = () => {

    
    const navigate = useNavigate(); 


 

    const handleTurn = () => {
        navigate('/turn');  
    };


   


    return (
        <div style={{
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            backgroundColor: '#232323',
            width: '60%',
            padding: '40px 21vw',  
            paddingTop: '75px',
            fontFamily: 'pixelify sans'
        }}>
        
        <button style={buttonStyle} onClick={handleTurn}>BATTLE</button>


            
        </div>
    );
};



const buttonStyle = {
    background: 'none',
    color: 'white',
    border: 'none',
    padding: '25px',
    fontSize: '30px',
    cursor: 'pointer',
    outline: 'none'
};



export default StripThree;



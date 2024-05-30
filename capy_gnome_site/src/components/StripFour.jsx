import React from 'react';


import { useNavigate } from 'react-router-dom';


const StripFour = () => {

    
    const navigate = useNavigate(); 


 

    const handleWinning = () => {
        navigate('/winnings');  
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
        
        <button style={buttonStyle} onClick={handleWinning}>CLAIM WINNING</button>
        



            
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



export default StripFour;



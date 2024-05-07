import React from 'react';
import { useNavigate } from 'react-router-dom';


const Rules = () => {


    const navigate = useNavigate();


    return (

        
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            
            <h1>Rules</h1>

            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px'}}>Overview</p>
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '14px'}}>Some stuff about the game and how the game is played.</p>


            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>Permanents</p>
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '14px'}}>Some stuff about the game and how the Permanents operate.</p>


            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>More</p>
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '14px'}}>Some stuff about the game.</p>



            <button onClick={() => navigate('/')} style={buttonBackStyle}>Home</button>

        </div>
    );
};







const buttonBackStyle = {
    width: '10%',
    padding: '10px',
    marginTop: '75px',
    backgroundColor: 'blue',
    color: 'black',
    fontSize: '16px',
    border: 'none',
    cursor: 'pointer'
};





export default Rules;

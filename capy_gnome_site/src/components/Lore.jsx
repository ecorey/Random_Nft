import React from 'react';
import capy_general from '../assets/capy_general.jpg';
import capy_monster from '../assets/capy_monster.jpg';
import capy_rider from '../assets/capy_rider.png';
import capy_soldier from '../assets/capy_soldier.jpg';
import gnome_general from '../assets/gnome_general.jpg';
import gnome_monster from '../assets/gnome_monster.jpg';
import gnome_rider from '../assets/gnome_rider.jpg';
import gnome_soldier from '../assets/gnome_soldier.jpg';

import { useNavigate } from 'react-router-dom';


const Lore = () => {


    const navigate = useNavigate();


    return (

        
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            <h1>Lore Page</h1>

            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px'}}>The Capys</p>
            
            <div style={gridStyle}>
                {/* Capy Images */}
                <div style={imageContainerStyle}>
                    <img src={capy_general} alt="Capy General" style={imageStyle} />
                    <p style={captionStyle}>Capy General</p>
                </div>

                <div style={imageContainerStyle}>
                    <img src={capy_monster} alt="Capy Monster" style={imageStyle} />
                    <p style={captionStyle}>Capy Monster</p>
                </div>

                <div style={imageContainerStyle}>
                    <img src={capy_rider} alt="Capy Rider" style={imageStyle} />
                    <p style={captionStyle}>Capy Rider</p>
                </div>

                <div style={imageContainerStyle}>
                    <img src={capy_soldier} alt="Capy Soldier" style={imageStyle} />
                    <p style={captionStyle}>Capy Soldier</p>
                </div>
            </div>



            <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto' }}></div>
            

            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px'}}>The Gnomes</p>

            <div style={gridStyle}>
                {/* Gnome Images */}
                <div style={imageContainerStyle}>
                    <img src={gnome_general} alt="Gnome General" style={imageStyle} />
                    <p style={captionStyle}>Gnome General</p>
                </div>

                <div style={imageContainerStyle}>
                    <img src={gnome_monster} alt="Gnome Monster" style={imageStyle} />
                    <p style={captionStyle}>Gnome Monster</p>
                </div>

                <div style={imageContainerStyle}>
                    <img src={gnome_rider} alt="Gnome Rider" style={imageStyle} />
                    <p style={captionStyle}>Gnome Rider</p>
                </div>

                <div style={imageContainerStyle}>
                    <img src={gnome_soldier} alt="Gnome Soldier" style={imageStyle} />
                    <p style={captionStyle}>Gnome Soldier</p>
                </div>


            </div>

            <button onClick={() => navigate('/')} style={buttonBackStyle}>Home</button>

        </div>
    );
};



const gridStyle = {
    display: 'grid',
    gridTemplateColumns: 'repeat(2, 1fr)', 
    gap: '10px', 
    marginBottom: '20px' 
};


const imageContainerStyle = {
    padding: '10px', 
    border: '2px solid white', 
    boxSizing: 'border-box'
};


const imageStyle = {
    width: '100%', 
    display: 'block', 
};


const captionStyle = {
    color: 'white', 
    fontSize: '14px', 
    marginTop: '5px',
    textAlign: 'center',
    fontFamily: 'pixelify sans'
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





export default Lore;

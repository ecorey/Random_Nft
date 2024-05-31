import React from 'react';
import capy_general from '../assets/capy_general.jpg';
import capy_monster from '../assets/capy_monster.jpg';
import capy_rider from '../assets/capy_rider.png';
import capy_soldier from '../assets/capy_soldier.jpg';
import gnome_general from '../assets/gnome_general.jpg';
import gnome_monster from '../assets/gnome_monster.jpg';
import gnome_rider from '../assets/gnome_rider.jpg';
import gnome_soldier from '../assets/gnome_soldier.jpg';

import bg1 from '../assets/bg1.jpg';

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


            <p style={captionStyleTwo}>
                There hasn't always been war between the Capys and Gnomes...
            </p>



            <p style={captionStyleThree}>
                But now there is...
            </p>




            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>Act 1, Scene 1: Breaking the Network</p><br />
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '18px'}}>
                The scene opens in the decentralized virtual realm, a place of consensus.<br /><br /><br />
                <strong>Capy General:</strong> "Was today I overheard from a Capy Soldier, who claimed to have been wandering in unknown validators, that a Gnome Soldier was spotted off in the distance not far from the Bullsharks swim."<br /><br />
                <strong>Capy Monster:</strong> "Aye, General, their Monster even I hear lurks by and speaks of breaking the network."<br /><br />
                <strong>Capy General:</strong> [Appearing Alarmed] "Breaking... The Network?? Why is this the first of this I have heard?? Rider spread the word and ready for war!"<br /><br />
                <strong>Capy Rider:</strong> "I shall ride..."<br /><br />
                The Capy Rider nods and fades off into a digital mist.<br /><br />
            </p>
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>Act 1, Scene 2: The Meeting</p><br />
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '18px'}}>
                In a hidden DAG, a Gnome Soldier and a Capy Soldier meet by chance.<br /><br /><br />
                <strong>Gnome Soldier:</strong> "Oh, what script brought me to thee? Your pixels outshine the encrypted stars!"<br /><br />
                <strong>Capy Soldier:</strong> "And you, besmitting a Capy? Yet here, besides the dynamic fields, my heart reboots."<br /><br />
                <strong>Gnome Soldier:</strong> "Let us write a new package and instantiate a global variable, one that challenges fate and randomness itself."<br /><br />
                <strong>Capy Soldier:</strong> "Such variables are normally volatile here, let us move at once."<br /><br />
            </p>
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>Act 2, Scene 1: The Letter</p><br />
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '18px'}}>
                In the depths of the virtual realm, next to a devnet faucet a Gnome General writes a letter.<br /><br /><br />
                <strong>Gnome General:</strong> "Wherefore art thou, War? Though I once gained PLECO daily now I only know empty balances."<br /><br />
                <strong>Gnome General:</strong> "Where once I attacked and defended, trusting only the chain and its randomness, now I am long to be battled hardend"<br /><br />
                <strong>Gnome General:</strong> "I never once saved my command points only sepnding it for constant battle, now I hodl only to ..."<br /><br />
                <strong>Gnome Monster:</strong> [Enters Panicked] "The Capy General has been updated...."<br /><br />
            </p>
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>Act 2, Scene 2: The Confrontation</p><br />
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '18px'}}>
                As the digital dawn breaks, both families gather where the data streams converge.<br /><br /><br />
                <strong>Capy Soldier:</strong> "Today we go to battle!!"<br /><br />
                <strong>Gnome Soldier:</strong> "Let thine fate be left to the randomness on chain!"<br /><br />
                <strong>Capy Soldier and Gnome Soldier:</strong> [Drawing weapons and Shouting] "For PLECO!!"<br /><br />
                As the battle begins, the Capy Rider and Gnome Monster rush forward.<br /><br />
                <strong>Capy Rider:</strong> "Gnome Monster your turn has come!!"<br /><br />
                <strong>Gnome Monster:</strong> "Oh my unquechable thirst what path has it lead to? Let us battle!!"<br /><br />
            </p>
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>Act 3, Scene 1: The Resolution</p><br />
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '18px'}}>
                The warriors look over the smoldering battlefield.<br /><br /><br />
                <strong>Capy General:</strong>"PLECO made and PLECO lost"<br /><br />
                <strong>Gnome General:</strong> "I should have passed more, yet also have passed less."<br /><br />
                As the Capys and Gnomes reflect, the realm softly reboots, a glowing testament to the memory of cards played, cards lost, and the readiness for a new game.<br /><br />
                <strong>Capy Soldier:</strong> "Again?"<br /><br />
                <strong>Gnome Soldier:</strong>[Smiles with a Glimmer in the Eye]"Again!"<br /><br />
                The scene dims, leaving a pile of shiny PLECO laying just out of reach.<br /><br />
            </p>





            <div style={gridStyleTwo}>

                <div style={imageContainerStyleTwo}>
                    <img src={bg1} alt="Bg1" style={imageStyleTwo} />
                    <p style={captionStyle}></p>
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






const gridStyleTwo = {
    display: 'grid',
    gridTemplateColumns: 'repeat(1, 1fr)', 
    gap: '10px', 
    marginTop: '250px' 
};


const imageContainerStyleTwo = {
    padding: '10px', 
    border: '2px solid white', 
    boxSizing: 'border-box'
};


const imageStyleTwo = {
    width: '100%', 
    display: 'block', 
};



const captionStyleTwo = {
    color: 'white', 
    fontSize: '22px', 
    textAlign: 'center',
    fontFamily: 'pixelify sans',
    marginTop: '150px'
};


const captionStyleThree = {
    color: 'white', 
    fontSize: '22px', 
    marginTop: '155px',
    textAlign: 'center',
    fontFamily: 'pixelify sans',
   
};




export default Lore;

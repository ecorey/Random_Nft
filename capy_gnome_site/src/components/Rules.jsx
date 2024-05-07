import React from 'react';
import { useNavigate } from 'react-router-dom';


const Rules = () => {


    const navigate = useNavigate();


    return (

        
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            
            <h1>Rules</h1>

            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px'}}>Overview</p>
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '16px'}}>
            - Coin Toss: The player to go first is determined by a 50/50 coin toss.<br />
            <br />
            - First Turn: For the first turn each player starts with 3 /6/9 CP and will earn 1 CP at the start of each turn after that.<br />
            <br />
            - The game depends on being able to build up CP by using cheaper defenses and less costly plays and needing to bluff the other player.<br />
            <br />
            - When a player has a turn they will chose to attack or pass. If they attack they will be limited by their CP. The defender at the beginning of the turn is given the option of which defense to play. The outcome of the battle is then decided and the points are updated.<br />
            <br />
            - The winner is determined by last man standing as each players permanents add up to 10 LP. <br />
            </p>


            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>Permanents</p>
            <p style={{ fontFamily: 'pixelify sans', color: 'white', fontSize: '16px' }}>
                <strong>General</strong><br />
                Attack: 10<br />
                Defense: 2<br />
                Health: 3<br />
                Cost: 6<br />
                <br />
                <strong>Monster</strong><br />
                Attack: 8<br />
                Defense: 8<br />
                Health: 6<br />
                Cost: 5<br />
                <br />
                <strong>Rider</strong><br />
                Attack: 6<br />
                Defense: 6<br />
                Health: 4<br />
                Cost: 4<br />
                <br />
                <strong>Soldier</strong><br />
                Attack: 4<br />
                Defense: 4<br />
                Health: 7<br />
                Cost: 2<br />
            </p>



            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>Probabilites of Success</p>
            <p style={{ fontFamily: 'pixelify sans', color: 'white', fontSize: '16px' }}>
                <strong>Soldier</strong><br />
                Soldier Vs. Soldier: 50%<br />
                Soldier Vs. Rider: 40%<br />
                Soldier Vs. Monster: 33%<br />
                Soldier Vs. General: 66%<br />
                <br />
                <strong>Rider</strong><br />
                Rider Vs. Soldier: 60%<br />
                Rider Vs. Rider: 50%<br />
                Rider Vs. Monster: 40%<br />
                Rider Vs. General: 75%<br />
                <br />
                <strong>Monster</strong><br />
                Monster Vs. Soldier: 60%<br />
                Monster Vs. Rider: 55%<br />
                Monster Vs. Monster: 50%<br />
                Monster Vs. General: 80%<br />
                <br />
                <strong>General</strong><br />
                General Vs. Soldier: 70%<br />
                General Vs. Rider: 60%<br />
                General Vs. Monster: 55%<br />
                General Vs. General: 80%<br />
            </p>


            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px', paddingTop: '45px'}}>Defensive Positions</p>
            <p style={{ fontFamily: 'pixelify sans', color: 'white', fontSize: '16px' }}>
                <strong>Frontline: (CP: FREE)</strong><br />
                - Soldier: 25%<br />
                - Rider: 25%<br />
                - Monster: 25%<br />
                - General: 25%<br />
                <br />
                <strong>Backline: (CP: 1)</strong><br />
                - Soldier: 75%<br />
                - Rider: 15%<br />
                - Monster: 5%<br />
                - General: 5%<br />
            </p>





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

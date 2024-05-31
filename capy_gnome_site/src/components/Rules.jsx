import React from 'react';
import { useNavigate } from 'react-router-dom';


const Rules = () => {


    const navigate = useNavigate();


    return (

        
        <div style={{ padding: '20px', maxWidth: '600px', margin: '20px auto', textAlign: 'center' }}>
            
            <h1>Rules</h1>

            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '28px'}}>Overview</p>
            <p style={{fontFamily: 'pixelify sans', color: 'white', fontSize: '16px'}}>
            - TRUST THE CHAIN<br />
            <br />
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
                Health: 1<br />
                Cost: 8<br />
                <br />
                <strong>Monster</strong><br />
                Health: 1<br />
                Cost: 6<br />
                <br />
                <strong>Rider</strong><br />
                Health: 1<br />
                Cost: 4<br />
                <br />
                <strong>Soldier</strong><br />
                Health: 1<br />
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
            <strong>Frontline Defense Stance Percent Chance of Being Attacked According to Cards Left:</strong><br />
            (g: general, m: monster, r: rider, s: soldier)<br />
            g: 25%, m: 25%, r: 25%, s: 25%<br />
            g: 33%, m: 33%, r: 34%<br />
            g: 33%, m: 33%, s: 34%<br />
            g: 33%, r: 33%, s: 34%<br />
            m: 33%, r: 33%, s: 34%<br />
            g: 50%, m: 50%<br />
            g: 50%, r: 50%<br />
            m: 50%, r: 50%<br />
            g: 50%, s: 50%<br />
            m: 50%, s: 50%<br />
            r: 50%, s: 50%<br />
            g: 100%<br />
            m: 100%<br />
            r: 100%<br />
            s: 100%<br />
            <br />
            <strong>Backline Defense Stance Percent Chance of Being Attacked According to Cards Left:</strong><br />
            (g: general, m: monster, r: rider, s: soldier)<br />
            g: 5%, m: 5%, r: 15%, s: 75%<br />
            g: 5%, m: 20%, r: 75%<br />
            g: 5%, m: 20%, s: 75%<br />
            g: 5%, r: 20%, s: 75%<br />
            m: 5%, r: 20%, s: 75%<br />
            g: 20%, m: 80%<br />
            g: 20%, r: 80%<br />
            m: 20%, r: 80%<br />
            g: 20%, s: 80%<br />
            m: 20%, s: 80%<br />
            r: 20%, s: 80%<br />
            g: 100%<br />
            m: 100%<br />
            r: 100%<br />
            s: 100%<br />
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

import React, { useState } from 'react';
import capy_general from '../assets/capy_general.jpg'; 
import gnome_general from '../assets/gnome_general.jpg'; 
import '../App.css';

function Box() {
  const [readLevel, setReadLevel] = useState(0);

  const content = [
    { text: "Leveraging the SUI Framework Random module and a Closed-Loop Token to power gameplay, Capy Vs Gnome is a 'MTG' style game where players can battle each other using their own decks of cards till the last one is standing." },
    { image: capy_general },
    { text: "VS" }, 
    { image: gnome_general },
    // { text: "MINT A DECK" },
    // { text: "CONFIRM A DECK" },
    { text: "Ready to start a game? Mint a Deck, Confirm it, Battle!" }
  ];

  const handleReadMore = () => {
    if (readLevel < content.length - 1) {
      setReadLevel(readLevel + 1);
    }
  };

  const handleReadLess = () => {
    if (readLevel > 0) {
      setReadLevel(readLevel - 1);
    }
  };

  return (
    <>
      <div className="content">
        <h1>CAPY Vs GNOME</h1>
        <div className="text">
          {content.slice(0, readLevel + 1).map((item, index) => {
            if (item.text) {
              const textStyle = item.text === "VS" ? { fontSize: '64px', fontWeight: 'bold' } : null;
              return <p key={index} style={textStyle}>{item.text}</p>;
            } else if (item.image) {
              return (
                <img
                  key={index}
                  src={item.image}
                  alt="Game Visual"
                  className="game-image"
                  style={{ width: '100%', maxWidth: '400px', height: 'auto' }}
                />
              );
            }
            return null;
          })}
        </div>
        <div className="buttons">
          {readLevel > 0 && (
            <button className="btn-2" onClick={handleReadLess}>Read Less</button>
          )}
          {readLevel < content.length - 1 && (
            <button className="btn-1" onClick={handleReadMore}>Read More</button>
          )}
        </div>
      </div>
    </>
  );
}

export default Box;

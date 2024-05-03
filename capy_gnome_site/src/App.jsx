import React, { useState } from 'react';
import capy_general from './assets/capy_general.jpg'; 
import './App.css';

function App() {
  const [readLevel, setReadLevel] = useState(0);

  const content = [
    { text: "Leveraging the SUI Framework Random module and a Closed-Loop Token to power gameplay, Capy Vs Gnome is a 'MTG' style game where players can battle each other using their own decks of cards till the last one is standing." },
    { image: capy_general },
    { text: "MINT A DECK" },
    { text: "CONFIRM A DECK" },
    { text: "Ready to start a game? Check the chain to ensure your deck is ready to go!" }
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
          <p>{content[0].text}</p>
          {readLevel > 0 && content[1].image && (
            <img 
              src={content[1].image} 
              alt="Game Visual" 
              className="game-image" 
              style={{ width: '100%', maxWidth: '400px', height: 'auto' }} 
            />
          )}
          {readLevel > 1 && <p>{content[2].text}</p>}
          {readLevel > 2 && <p>{content[3].text}</p>}
          {readLevel > 3 && <p>{content[4].text}</p>}
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

export default App;

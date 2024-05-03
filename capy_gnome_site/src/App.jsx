import React, { useState } from 'react';
import './App.css';

function App() {
  const [readLevel, setReadLevel] = useState(0); // Initial state with 0 showing the base level text only

  const content = [
    "Leveveraging the SUI Framework Random module and a Closed-Loop Token to power gameplay, Capy Vs Gnome is a 'MTG' style game where players can battle each other using their own decks of cards till the last one is standing.", 
    "MINT A DECK",
    "CONFIRM A DECK",
    "Ready to start a game? Check the chain to ensure your deck is ready to go!"
  ];

  const handleReadMore = () => {
    if (readLevel < content.length - 1) { // Prevents going beyond available content levels
      setReadLevel(readLevel + 1);
    }
  };

  const handleReadLess = () => {
    if (readLevel > 0) { // Prevents going below the initial text
      setReadLevel(readLevel - 1);
    }
  };

  return (
    <>
      <div className="content">
        <h1>CAPY Vs GNOME</h1>
        <div className="text">
          <p>{content[0]}</p>
          {readLevel > 0 && <p>{content[1]}</p>}
          {readLevel > 1 && <p>{content[2]}</p>}
          {readLevel > 2 && <p>{content[3]}</p>} {/* New level added */}
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

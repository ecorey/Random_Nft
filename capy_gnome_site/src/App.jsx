import React, { useState, useRef } from 'react';
import './App.css';

function App() {

  const [showMore, setShowMore] = useState(false);
  

  const handleReadMore = () => {
    setShowMore(true);
    
  };

  const handleReadLess = () => {
    setShowMore(false);
  };

  return (
    <>
      <div className="content">

        <h1>CAPY Vs GNOME</h1>
        
        <div className="text">
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          {showMore && (
            <p id="hidden">Yeah it's what you hoped for, another ...Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          )}
        </div>
        <div className="buttons">
          {!showMore && <button className="btn-1" onClick={handleReadMore}>Read More</button>}
          {showMore && <button className="btn-2" onClick={handleReadLess}>Read Less</button>}
        </div>
        
      </div>
    </>
  );
}

export default App;

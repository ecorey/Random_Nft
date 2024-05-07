import React, { useState } from 'react';
import './App.css';
import Box from './components/Box';
import Strip from './components/Strip';
import NavBar from './components/NavBar';
import Footer from './components/Footer';



function App() {
  return (
    
      <div>
        <NavBar />
        <Box />
        <Strip />
        <Footer />
      </div>
    
  );
}

export default App;

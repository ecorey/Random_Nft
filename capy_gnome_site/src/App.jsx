import React from 'react';
import './App.css';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Box from './components/Box';
import Strip from './components/Strip';
import NavBar from './components/NavBar';
import Footer from './components/Footer';
import ConfirmDeck from './components/ConfirmDeck';  

function App() {
  return (
    <Router>
      <div>
        <NavBar />
        <Routes>
          <Route path="/" element={
            <>
              <Box />
              <Strip />
            </>
          } />
          <Route path="/confirm" element={<ConfirmDeck />} />
        </Routes>
        <Footer />
      </div>
    </Router>
  );
}

export default App;

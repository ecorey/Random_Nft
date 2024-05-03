import {ConnectButton} from '@suiet/wallet-kit';
import '../index.css'






const NavBar = () => {
  return (
    <div style={{ display: 'flex', justifyContent: 'flex-end', padding: '10px', backgroundColor: '#232323', width: '100%' }}>
        <ConnectButton />
    </div>
  );
};





export default NavBar;

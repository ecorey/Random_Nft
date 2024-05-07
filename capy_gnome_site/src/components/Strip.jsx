const Strip = () => {
    return (
        <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            backgroundColor: '#232323',
            width: '100%',
            padding: '40px 16vw',  
            fontFamily: 'pixelify sans'
        }}>
            <div style={{
                display: 'flex',
                gap: '15px',
                flexWrap: 'wrap',
                paddingLeft: '50px'  
            }}>  
                <h2>MINT CAPY DECK</h2>
                <h2>CONFIRM CAPY DECK</h2>
                <h2>MINT GNOME DECK</h2>
                <h2>CONFIRM GNOME DECK</h2>
            </div>
        </div>
    );
};

export default Strip;

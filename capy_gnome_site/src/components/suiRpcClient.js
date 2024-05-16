import axios from 'axios';

const SUI_RPC_URL = 'https://fullnode.devnet.sui.io:443'; 

const fetchGameStats = async (gameId) => {
    try {
        const response = await axios.post(SUI_RPC_URL, {
            method: 'sui_getObject',
            params: [gameId],
            jsonrpc: '2.0',
            id: 1
        });

        if (response.data.result) {
            const fields = response.data.result.details.data.fields;
            return fields;
        } else {
            throw new Error('No result returned from Sui RPC');
        }
    } catch (error) {
        console.error('Error fetching game stats:', error);
        throw error;
    }
};

export default fetchGameStats;

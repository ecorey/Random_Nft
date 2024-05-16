import axios from 'axios';

const SUI_RPC_URL = 'https://fullnode.devnet.sui.io:443';

const fetchGameStatsEvents = async (packageId, moduleId, limit = 100, cursor = null) => {
    const query = {
        "MoveModule": {
            "package": packageId,
            "module": moduleId
        }
    };
    const params = cursor ? [query, cursor, limit, false] : [query, limit, false];
    try {
        const response = await axios.post(SUI_RPC_URL, {
            method: 'suix_queryEvents',
            params: params,
            jsonrpc: '2.0',
            id: 1
        });

        if (response.data.result && response.data.result.data) {
            return response.data.result.data;
        } else {
            throw new Error('No result returned from Sui RPC');
        }
    } catch (error) {
        console.error('Error fetching game stats events:', error);
        throw error;
    }
};

export default fetchGameStatsEvents;

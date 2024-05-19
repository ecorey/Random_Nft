import { useSuiClientQuery } from '@mysten/dapp-kit';
import { Package } from '../../../scripts/config';

export function useFetchCoinFlipData(gameId) {
    const { data, isLoading, isError, error, refetch } = useSuiClientQuery(
        'getObject',
        {
            id: gameId,
            options: {
                showType: true,
                showContent: true,
            },
        },
        { queryKey: ['CoinFlipData', gameId] },
    );

    return {
        data: data?.data,
        isLoading,
        isError,
        error,
        refetch,
    };
}

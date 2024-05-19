import { useSuiClientQuery } from '@mysten/dapp-kit';
import { Package } from '../../../scripts/config';

export function useFetchGameData(gameId) {
    const { data, isLoading, isError, error, refetch } = useSuiClientQuery(
        'getObject',
        {
            id: gameId,
            options: {
                showType: true,
                showContent: true,
            },
        },
        { queryKey: ['GameData', gameId] },
    );

    return {
        data: data?.data,
        isLoading,
        isError,
        error,
        refetch,
    };
}

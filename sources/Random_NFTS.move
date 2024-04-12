module random_nfts::random_nfts {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::display::{Self, Display};


    #[test_only]
    friend random_nfts::random_nfts_tests;





    struct RANDOM_NFTS has drop {}


    fun init(otw: RANDOM_NFTS, ctx: &mut TxContext) {


        let publisher = package::claim(otw, ctx);


        transfer::public_transfer(publisher, tx_context::sender(ctx));




    }










    #[test_only]
    public fun init_for_testing(otw: RANDOM_NFTS, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}
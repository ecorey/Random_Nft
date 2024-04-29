module capy_vs_gnome::random_funcs {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::event;
    use std::string::{utf8, String};



    #[test_only]
    friend capy_vs_gnome::random_funcs_tests;


    use sui::random::{Self, Random};
    



    struct RANDOM_FUNCS has drop {}




    fun init(otw: RANDOM_FUNCS, ctx: &mut TxContext) {


    }















    #[test_only]
    public fun init_for_testing(otw: RANDOM_FUNCS, ctx: &mut TxContext) {
        init(otw, ctx);
    }







}
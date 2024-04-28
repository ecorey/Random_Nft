module capy_vs_gnome::monsti {



    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID};
    use sui::event;
    use std::string::{utf8, String};

    use sui::token::{Self, Token, ActionRequest};
    use sui::coin::{Self, TreasuryCap};


    #[test_only]
    friend capy_vs_gnome::monsti_tests;


    // Closed Loop Token used for CP to use cards and make moves




    struct MONSTI has drop {}




    fun init(otw: MONSTI, ctx: &mut TxContext) {

        


    }












}
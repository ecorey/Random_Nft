#[allow(unused_use)]
module capy_vs_gnome::pleco {



    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID};
    use sui::event;
    use std::string::{utf8, String};
    use std::option::{Self, Option};
    use sui::token::{Self, Token, ActionRequest};
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;

    use capy_vs_gnome::card_deck::{Trophy};


    #[test_only]
    friend capy_vs_gnome::pleco_tests;





    // CONTENTS:
    //    




    struct PLECO has drop {}


    // for rule 
    struct CardUse has drop {}




    fun init(otw: PLECO, ctx: &mut TxContext) {



        let (treasury_cap, coin_metadata) = coin::create_currency(
            otw,
            0,
            b"PLECO",
            b"Pleco",
            b"Pleco powered gas closed-loop token",
            option::none(),
            ctx,
        );


        let (policy, policy_cap) = token::new_policy(&treasury_cap, ctx);


        // constrained spend example
        token::add_rule_for_action<PLECO, CardUse>(
            &mut policy,
            &policy_cap,
            token::spend_action(),
            ctx,
        );


        token::share_policy(policy);

        transfer::public_freeze_object(coin_metadata);
        transfer::public_transfer(policy_cap, tx_context::sender(ctx));
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));


    }




    // mints 777 PLECO to the winner
    public fun winners_mint(
        cap: &mut TreasuryCap<PLECO>,
        recipient: address, 
        ctx: &mut TxContext,
    ) {
        let token = token::mint(cap, 777, ctx);
        let req = token::transfer(token, recipient, ctx);

        token::confirm_with_treasury_cap(cap, req, ctx);
    }




    






   







}
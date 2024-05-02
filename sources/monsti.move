module capy_vs_gnome::monsti {



    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID};
    use sui::event;
    use std::string::{utf8, String};
    use std::option::{Self, Option};
    use sui::token::{Self, Token, ActionRequest};
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;


    #[test_only]
    friend capy_vs_gnome::monsti_tests;


    // Closed Loop Token used for CP to use cards and make moves




    struct MONSTI has drop {}


    // for rule 
    struct CardUse has drop {}




    fun init(otw: MONSTI, ctx: &mut TxContext) {



        let (treasury_cap, coin_metadata) = coin::create_currency(
            otw,
            0,
            b"MONSTI",
            b"Monsti",
            b"Command Points for Capy Vs. Gnome",
            option::none(),
            ctx,
        );


        let (policy, policy_cap) = token::new_policy(&treasury_cap, ctx);


        // constrained spend example
        token::add_rule_for_action<MONSTI, CardUse>(
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




    // mint 4 MONSTI to the user at the start of first rounds of a turn
    public fun first_turns_mint(
        cap: &mut TreasuryCap<MONSTI>,
        ctx: &mut TxContext,
    ) {
        let token = token::mint(cap, 4, ctx);
        let req = token::transfer(token, tx_context::sender(ctx), ctx);

        token::confirm_with_treasury_cap(cap, req, ctx);
    }




    // mint 1 MONSTI to the user at the start of sebsequent turns
    public fun turn_mint(
        cap: &mut TreasuryCap<MONSTI>,
        ctx: &mut TxContext,
    ) {
        let token = token::mint(cap, 1, ctx);
        let req = token::transfer(token, tx_context::sender(ctx), ctx);

        token::confirm_with_treasury_cap(cap, req, ctx);
    }






    // reset the token balance to 0, needed to start a game
    public fun reset_balance() {

    }








}
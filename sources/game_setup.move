module capy_vs_gnome::game_setup {


    use sui::object::{Self, UID};
    use sui::event;
    use sui::clock::{Self, Clock};
    use sui::tx_context::{Self, TxContext};

    use sui::coin::{Self, TreasuryCap};
    use capy_vs_gnome::monsti::{MONSTI, turn_mint};
    use capy_vs_gnome::card_deck::{GnomeGeneral, GnomeMonster, GnomeRider, GnomeSoldier, confirm_gnome_cards, confirm_capy_cards};
    use capy_vs_gnome::card_deck::{ConfirmedGnomeDeck, ConfirmedCapyDeck};
     


    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------




    // GAME SETUP


    struct GAME_SETUP has drop {}



    struct Game has key, store {
        id: UID,
       
    }


    // event to get time from a timestamp_ms
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64
    }


    
    fun init(otw: GAME_SETUP, ctx: &mut TxContext) {


    }


    public fun start_game(player_one_deck: &ConfirmedGnomeDeck, player_two_deck: &ConfirmedCapyDeck, ctx: &mut TxContext) : Game {

       

        let game = Game {
            id: object::new(ctx),
           
        };

        game

    }




    public fun start_turn( cap: &mut TreasuryCap<MONSTI>, ctx: &mut TxContext) {

        turn_mint(cap, ctx);


    }



    




    public fun get_time(clock: &Clock)  {
        event::emit(TimeEvent {
            timestamp_ms: clock::timestamp_ms(clock),
        });

    }





















    #[test_only]
    public fun init_for_testing(otw: GAME_SETUP, ctx: &mut TxContext) {
        init(otw, ctx);
    }






}
module capy_vs_gnome::game_setup {


    use sui::object::{Self, UID};
    use sui::event;
    use sui::clock::{Self, Clock};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::coin::{Self, TreasuryCap};
    use capy_vs_gnome::monsti::{MONSTI, turn_mint};
    use capy_vs_gnome::card_deck::{GnomeGeneral, GnomeMonster, GnomeRider, GnomeSoldier, confirm_gnome_cards, confirm_capy_cards};
    use capy_vs_gnome::card_deck::{ConfirmedGnomeDeck, ConfirmedCapyDeck};

    use capy_vs_gnome::random_funcs::{arithmetic_is_less_than}; 
    use sui::random::{Self, Random, new_generator};
    


     


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




    public fun flip_the_coin(r: &Random, ctx: &mut TxContext) : u8 {

        let result = coin_toss(r, ctx);

        result

    }








    struct RandNum has key, store {
        id: UID,
        value: u8,
        bool_value: bool,
    }




    entry fun coin_toss(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 50%
        let fifty__percent = arithmetic_is_less_than(v, 51, 100); 


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        fifty__percent


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
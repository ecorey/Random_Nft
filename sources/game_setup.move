module capy_vs_gnome::game_setup {


    use sui::object::{Self, UID};
    use sui::event;
    use sui::clock::{Self, Clock};
    use sui::tx_context::{Self, TxContext};

    use sui::coin::{Self, TreasuryCap};
    use capy_vs_gnome::monsti::{MONSTI, turn_mint};

     


    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------




    // GAME SETUP



    struct Player has key, store{
        id: UID,
        // game_deck: Option<>,
        // extra_cards: Option<>,
    }


    struct Game has key, store {
        id: UID,
        player_one: Player,
        player_two: Player,
    }


    // event to get time from a timestamp_ms
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64
    }


    

    public fun start_turn( cap: &mut TreasuryCap<MONSTI>, ctx: &mut TxContext) {

        turn_mint(cap, ctx);


    }




    public fun game_setup(player_one: Player, player_two: Player, ctx: &mut TxContext) : Game {

        // assert!(player_one.game_deck == length(40));
        // assert!(player_two.game_deck == length(40));

        // assert that the player deck has each of the neeedd cards and appropriate number
        // assert!(player_one.game_deck );

        let game = Game {
            id: object::new(ctx),
            player_one,
            player_two,
        };

        game

    }




    public fun get_time(clock: &Clock)  {
        event::emit(TimeEvent {
            timestamp_ms: clock::timestamp_ms(clock),
        });

    }














}
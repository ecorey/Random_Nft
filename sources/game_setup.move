module capy_vs_gnome::game_setup {


    use sui::object::{Self, UID};
    use sui::event;
    use sui::clock::{Self, Clock};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::coin::{Self, TreasuryCap};
    use std::string::{Self, String};

    use capy_vs_gnome::monsti::{MONSTI, first_turns_mint};
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

        first_turns_mint(cap, ctx);


    }



    // 50% probability coin toss
    public fun coin_toss(r: &Random, ctx: &mut TxContext) : u8 {

        let result = fifty_percent_probability(r, ctx);

        result

    }



    struct FrontLineDefense has copy, drop, store {
        result: u8,
    }



    // frontline defense stance
    // free CP
    // returns 1 for general, 2 for monster, 3 for rider, 4 for soldier
    // will indicate which permenant is being attacked
    // 25% probability for each permenant
    entry fun frontline_defense_stance(r: &Random, ctx: &mut TxContext) : u8 {

        
        let general = 0;
        let monster = 0;
        let rider = 0;
        let soldier = 0;



        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        if (v <= 25) {
            general = 1;
        }; 

        if (v > 25 && v <= 50 ) {
            monster = 1;
        }; 

        if (v > 50 && v <= 75) {
            rider = 1;
        }; 

        if (v > 75 && v <= 100) {
            soldier = 1;
        };



        let result = 0;

        if(general == 1){
            result = 1;
        }; 

        if(monster == 1) {
            result = 2;
        }; 

        if(rider == 1) {
            result = 3;
        };  

        if(soldier == 1) {
            result = 4;
        };


        event::emit(FrontLineDefense {
            result: result,
        });


        
        

        result

    }



    struct BackLineDefense has copy, drop, store {
        result: u8,
    }



    // backline defense stance
    // add 1 CP cost
    // returns 1 for general, 2 for monster, 3 for rider, 4 for soldier
    // will indicate which permenant is being attacked
    // 5% probability for general, 5% for monster, 15% for rider, 75% for soldier
    entry fun backline_defense_stance(r: &Random, ctx: &mut TxContext) : u8 {

        
        let general = 0;
        let monster = 0;
        let rider = 0;
        let soldier = 0;



        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        if (v > 95 && v <= 100 ) {
            general = 1;
        }; 

        if (v > 90 && v <= 95 ) {
            monster = 1;
        }; 

        if (v > 75 && v <= 90) {
            rider = 1;
        }; 

        if (v <= 75) {
            soldier = 1;
        };



        let result = 0;

        if(general == 1){
            result = 1;
        }; 

        if(monster == 1) {
            result = 2;
        }; 

        if(rider == 1) {
            result = 3;
        };  

        if(soldier == 1) {
            result = 4;
        };




        event::emit(BackLineDefense {
            result: result,
        });
        

        result

    }






    struct RandNum has key, store {
        id: UID,
        value: u8,
        bool_value: bool,
    }





    // 25% probability
    entry fun twenty_five_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 25%
        let twenty_five_percent = arithmetic_is_less_than(v, 26, 100); 

        if(twenty_five_percent == 1) {
            result = true;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        twenty_five_percent


    }


    


    // 33% probability
    entry fun thirty_three_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 33%
        let thirty_three_percent = arithmetic_is_less_than(v, 34, 100); 


        if(thirty_three_percent == 1) {
            result = true;
        };



        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        thirty_three_percent


    }



    // 40% probability
    entry fun forty_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 40%
        let forty_percent = arithmetic_is_less_than(v, 41, 100); 


        if(forty_percent == 1) {
            result = true;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        forty_percent


    }




    // 50% probability
    entry fun fifty_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 50%
        let fifty_percent = arithmetic_is_less_than(v, 51, 100); 



        if(fifty_percent == 1) {
            result = true;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        fifty_percent


    }




    // 55% probability
    entry fun fifty_five_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 55%
        let fifty_five_percent = arithmetic_is_less_than(v, 56, 100);



        if(fifty_five_percent == 1) {
            result = true;
        }; 


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        fifty_five_percent


    }




    // 60% probability
    entry fun sixty_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 60%
        let sixty_percent = arithmetic_is_less_than(v, 61, 100); 


        if(sixty_percent == 1) {
            result = true;
        }; 


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        sixty_percent


    }



    // 66% probability
    entry fun sixty_six_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 66%
        let sixty_six_percent = arithmetic_is_less_than(v, 67, 100); 


        if(sixty_six_percent == 1) {
            result = true;
        }; 



        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        sixty_six_percent


    }



    // 70% probability
    entry fun seventy_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 70%
        let seventy_percent = arithmetic_is_less_than(v, 71, 100); 


        if(seventy_percent == 1) {
            result = true;
        }; 



        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        seventy_percent


    }



    // 75% probability
    entry fun seventy_five_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 75%
        let seventy_five_percent = arithmetic_is_less_than(v, 76, 100); 



        if(seventy_five_percent == 1) {
            result = true;
        }; 



        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        seventy_five_percent


    }




    // 80% probability
    entry fun eighty_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);


        // probability of 80%
        let eighty_percent = arithmetic_is_less_than(v, 81, 100); 


        if(eighty_percent == 1) {
            result = true;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        eighty_percent


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
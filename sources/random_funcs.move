module capy_vs_gnome::random_funcs {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::event;
    use std::string::{utf8, String};



    #[test_only]
    friend capy_vs_gnome::random_funcs_tests;
    friend capy_vs_gnome::game_setup;



    use sui::random::{Self, Random, new_generator};
    



    struct RANDOM_FUNCS has drop {}




    fun init(otw: RANDOM_FUNCS, ctx: &mut TxContext) {


    }


    struct RandNumEvent has copy, drop {
        value: u8
    }



    struct RandNum has key, store {
        id: UID,
        value: u8,
        bool_value: bool,
    }



    entry fun ten_percent_probability(r: &Random, ctx: &mut TxContext )  {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);


        event::emit(RandNumEvent { value: v });


        // probability of 10%
        let ten__percent = arithmetic_is_less_than(v, 11, 100); 


        if(ten__percent == 1) {
            result = true;
        } else {
            result = false;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };


        


        transfer::public_transfer(result, tx_context::sender(ctx));

    }







    entry fun fifty_percent_probability(r: &Random, ctx: &mut TxContext )  {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);


        event::emit(RandNumEvent { value: v });


        // probability of 50%
        let fifty__percent = arithmetic_is_less_than(v, 51, 100); 


        if(fifty__percent == 1) {
            result = true;
        } else {
            result = false;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };


        


        transfer::public_transfer(result, tx_context::sender(ctx));

    }




    











    // Returns 1 if true, 0 false.
    // Safe in case w and v_max are independent of the randomenss (e.g., fixed).
    // Does not check if v <= v_max.
    public fun arithmetic_is_less_than(v: u8, w: u8, v_max: u8): u8 {
        assert!(v_max >= w && w > 0, 1);
        let v_max_over_w = v_max / w;
        let v_over_w = v / w; // 0 if v < w, [1, v_max_over_w] if above
        (v_max_over_w - v_over_w) / v_max_over_w
    }










    #[test_only]
    public fun init_for_testing(otw: RANDOM_FUNCS, ctx: &mut TxContext) {
        init(otw, ctx);
    }







}